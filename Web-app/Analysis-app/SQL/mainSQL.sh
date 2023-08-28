#!/bin/bash

cd Analysis-app/SQL

green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
purple_color() { echo -en "\e[35m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

# Variables y configuraciones locales
IP=$1
pathMsfconsole=/opt/metasploit/msfconsole
rm -rf temp; mkdir temp

sed 's/_IP_TARGET_/'$IP'/g' testSQL.rc > temp/temp_testSQL.rc
sed 's/_IP_TARGET_/'$IP'/g' testSQLver.rc > temp/temp_testSQLver.rc

echo -e "\n[] PROBANDO EXISTENCIA DE SERVICIOS SQL...\n"
version=""

# Se intenta 3 veces encontrar la version de MySQL (por alguna razon, no suele encontrarla a la primera)
for (( cont=1; cont <=3; cont++)); do

    # Usar Metasploit con el fichero de comandos temporal
    $pathMsfconsole -q -r temp/temp_testSQLver.rc > temp/outver.txt 2> /dev/null
    var=$(cat "temp/outver.txt")

    # Comprobar existencia de servicios SQL (MySQL)
    discRES=$(echo -e "$var" | grep "$IP:3306 is running MySQL" | cut -d "-" -f2 | wc -l)
    version=$(echo -e "$var" | grep "is running MySQL" | awk -F 'is running' '{print $2}')
    if [ $discRES -eq 0 ]; then
        red_color; echo -en " > No se ha conseguido encontrar la version de MySQL en $IP.\n"; default_color
    else
        green_color; echo -e " > Servicios SQL encontrados en $IP.\n > Version:$version\n"; default_color
        break
    fi

done

echo -e "[] ENUMERACIÓN Y EXPLORACIÓN DE SERVICIOS SQL..."

# Usar Metasploit con el fichero de comandos temporal
$pathMsfconsole -q -r temp/temp_testSQL.rc > temp/out.txt 2> /dev/null
var=$(cat "temp/out.txt")

# Conseguir credenciales de usuarios hasheadas
purple_color; echo -e "\n > Usuario - contraseña hasheada encontrados: \n--------------------------------"; default_color
userPass=$(echo -e "$var" | grep "Saving HashString as Loot" | awk -F 'Saving HashString as Loot:' '{print $2}')
echo -e "$userPass"

# Parsear esquemas encontrados
n_dbs=$(echo -e "$var" | grep "DBName:" | wc -l)
db_names=$(echo -e "$var" | grep "DBName:" | cut -d ":" -f2)
n_tablas=$(echo -e "$var" | grep "TableName:" | wc -l)
purple_color; echo -e "\n > Bases de datos encontradas: \n --------------------------------"; default_color
echo "Numero de BDs: $n_dbs"
nloop=1
db_array=()
for i in $db_names; do
    echo "  $nloop. $i"
    nloop=$((nloop+1))
    db_array+=($i)
done

# crear JSONs
userPass_array=($userPass)
credenciales_json=" [  "
for ((i=0; i<${#userPass_array[@]}; i++)); do
    localUser=$(echo "${userPass_array[i]}" | cut -d ":" -f1)
    localPassword=$(echo "${userPass_array[i]}" | cut -d ":" -f 2-)
    credenciales_json="$credenciales_json { \"user\": \"$localUser\", \"password\": \"$localPassword\" }, "
done
credenciales_json="${credenciales_json%??}"
credenciales_json="$credenciales_json ] "

dbs_json=" [  "
for i in "${!db_array[@]}"; do
    line_db=$(echo -e "$var" | grep -w "DBName: ${db_array[i]}" -n | cut -d ":" -f1)
    line_next_db=$(echo -e "$var" | grep -w "DBName: ${db_array[i+1]}" -n | cut -d ":" -f1)
    if [ "$line_next_db" == "" ]; then line_next_db=$(echo -e "$var" | wc -l); line_next_db=$((line_next_db-4)); fi
    dbContents=$(echo "$var" | sed -n "$((line_db+1)),$((line_next_db-1))"p)
    dbTableNames=$(echo -e "$dbContents" | grep "TableName:")
    
    tablas_array=()
    for tabla in $dbTableNames; do
        if [ "$tabla" == "-" ] || [ "$tabla" == "TableName:" ]; then continue; fi
        tablas_array+=($tabla)
    done
    
    tablas_db_json=" [  "

    for tabla in "${!tablas_array[@]}"; do
        currentTable="TableName: ${tablas_array[tabla]}"
        nextTable="TableName: ${tablas_array[tabla+1]}"
        line_current_table=$(echo -e "$dbContents" | grep -w "$currentTable" -n | cut -d ":" -f1)
        line_next_table=$(echo -e "$dbContents" | grep -w "$nextTable" -n | cut -d ":" -f1)
        if [ "$line_next_table" == "" ]; then line_next_table=$(echo -e "$dbContents" | wc -l)+1; fi

        tableContent=$(echo -e "$dbContents" | sed -n "$((line_current_table+2)),$((line_next_table-1))"p)

        tableContentList=$(echo "$tableContent" | awk -F ':' '{print $2":"$3}')
        tableContentList=$(echo "$tableContentList" | sed 's/:$//g')
        
        localCont=0
        localList=""
        localTotalList=" [  "
        for dato in $tableContentList; do
            localCont=$((localCont+1))
            if [ $localCont -eq 1 ]; then
                localList=" { \"name\" : \"$dato\","
            fi
            if [ $localCont -eq 2 ]; then
                localCont=0
                localList="$localList \"type\" : \"$dato\" }"
                localTotalList="$localTotalList $localList, "
            fi
        done
        
        localTotalList="${localTotalList%??}"; localTotalList="$localTotalList ] "
        tablas_db_json="$tablas_db_json { \"name\" : \"${tablas_array[tabla]}\", \"content\" : $localTotalList }, "

    done

    if [ "$tablas_db_json" == " [  " ]; then tablas_db_json=" [ ] "; fi
    tablas_db_json="${tablas_db_json%??}"; tablas_db_json="$tablas_db_json ] "
    dbs_json="$dbs_json { \"name\" : \"${db_array[i]}\", \"tables\" : $tablas_db_json }, "
done

dbs_json="${dbs_json%??}"; dbs_json="$dbs_json ] "

echo -e "\nTablas totales: $n_tablas\n"
purple_color; echo -e " > Toda la información de los esquemas guardada en JSON"; default_color

# Conseguir informacion adicional mediante scripts de nmap
nmap -p 3306 --script=mysql-info $IP > temp/out-sql-info.txt
nmapRes_sqlinfo=$(cat temp/out-sql-info.txt)

capabilitiesFlags=$(echo "$nmapRes_sqlinfo" | grep "Capabilities flags:" | cut -d ":" -f2)
echo "Capabilities flags: $capabilitiesFlags"
status=$(echo "$nmapRes_sqlinfo" | grep "Status:" | cut -d ":" -f2)
echo "Status: $status"
sal=$(echo "$nmapRes_sqlinfo" | grep "Salt:" | cut -d ":" -f2)
echo "Salt: $sal"

somecapabilities=$(echo "$nmapRes_sqlinfo" | grep "Some Capabilities:" | cut -d ":" -f2)
echo "Some Capabilities: $somecapabilities"
IFSoriginal=$IFS
IFS=","
for cap in $somecapabilities; do
    echo " > Capability: $cap"
done
IFS=$IFSoriginal

capabilitiesJSON=" [  "
for cap in $somecapabilities; do capabilitiesJSON="$capabilitiesJSON \"$cap\", "; done
capabilitiesJSON="${capabilitiesJSON%??}"; capabilitiesJSON="$capabilitiesJSON ] "

# crear JSON final con los resultados del protocolo
filename="enumedSQL.json"
PROT="SQL"

json_string='{ "protocolo": "'$PROT'", "version": "'$version'", 
"capabilities_flags": "'$capabilitiesFlags'", "capabilities": '$capabilitiesJSON', "status": "'$status'",
"credentials": '$credenciales_json', "db_scheme": '$dbs_json' }'

echo $json_string > "${filename}"

rm -rf temp