#!/bin/bash

cd Analysis-app/SAMBA

purple_color() { echo -en "\e[35m\e[1m"; }
green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
yellow_color() { echo -en "\e[33m\e[1m"; }
blue_color() { echo -en "\e[34m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

# Variables y configuraciones locales
IP=$1
pathMsfconsole=/opt/metasploit/msfconsole
rm -rf temp; mkdir temp

# Crear fichero de comandos de Metasploit temporal con la configuración de la máquina objetivo
sed 's/_IP_TARGET_/'$IP'/g' testSAMBA.rc > temp/temp_testSAMBA.rc

# Ejecutar Metasploit con el fichero de comandos temporal
echo -e "\n[] PROBANDO EXISTENCIA DE SERVICIOS SAMBA...\n"
$pathMsfconsole -q -r "temp/temp_testSAMBA.rc" > temp/out.txt 2> /dev/null
var=$(cat "temp/out.txt")

# Comprobar existencia de SAMBA
version=$(echo -e "$var" | grep "Samba" | cut -d "(" -f2 | cut -d ")" -f1)
if [ $(echo "$version" | wc -l) -eq 0 ]; then
    red_color; echo -n " > La máquina objetivo $IP no tiene servicios Samba.\n"; default_color
    exit 1
else
    green_color; echo -n " > Servicios Samba encontrados:" $version; default_color 
fi

# Enumeracion y descubrimiento de recursos compartidos
listing=$(smbclient -L $IP -U%)
lineTitle=$(echo "$listing" | grep "Sharename       Type      Comment" -n | cut -d ":" -f1)
lineTitleServer=$(echo "$listing" | grep "Server               Comment" -n | cut -d ":" -f1)
lineTitleWorkgroup=$(echo "$listing" | grep "Workgroup            Master" -n | cut -d ":" -f1)
echo -e "\n\n[] ENUMERACION Y DESCUBRIMIENTO SAMBA...\n"

sharenames=""
sharenamesJSON=""
servers=""
serversJSON=""
workgroups=""
sharenamesJSON=""

contador=1
acabarBucle=1

# Comprobar Workshares generales
while [ $acabarBucle -eq 1 ]
do
    linea=$(echo "$listing" | sed -n "${contador}p")
    if [ $contador -lt $lineTitle ]; then
        contador=$((contador+1))
        continue
    fi
    if [ -z "$linea" ]; then
        acabarBucle=0
        break
    fi

    contador=$((contador+1))
done

if [ $(echo "$listing" | sed -n "$((contador-1))"p | grep "Reconnecting with" | wc -w) -ne 0 ]; then
    sharenames=$(echo "$listing" | sed -n "$((lineTitle)),$((contador-2))"p)
    sharenames="$sharenames\n"
else
    sharenames=$(echo "$listing" | sed -n "$((lineTitle)),$((contador-1))"p)
fi

# Crear JSON de sharenames
localCont=1
sharenamesJSON=" [  "

if [ "$sharenames" != "" ]; then
    localVar=$(echo "$sharenames" | while read line
    do
        otherCont=1
        avanzar=0
        if [ $localCont -lt 3 ]; then
            localCont=$((localCont+1))
            continue
        fi
        for i in $(seq 0 ${#line}); do
            char=${line:i:1}
            if [ $avanzar -eq 1 ]; then
                if [ "$char" = " " ]; then
                    continue
                fi
            fi

            if [ "$char" = " " ] && [ "$otherCont" -lt 3 ]; then
                echo -n %
                otherCont=$((otherCont+1))
                avanzar=1
            fi

            if [ $avanzar -eq 1 ] && [ "$char" != " " ]; then
                avanzar=0
            fi

            echo -n $char
        done
        echo ""
    done)

    
    for linea in $localVar; do
        w1=$(echo $linea | cut -d "%" -f1) w1=\"$w1\"
        w2=$(echo $linea | cut -d "%" -f2) w2=\"$w2\"
        w3=$(echo $linea | cut -d "%" -f3) w3=\"$w3\"
        
        localList=" { "
        localList="$localList \"name\": $w1, "
        localList="$localList \"type\": $w2, "
        localList="$localList \"comment\": $w3 "
        localList="$localList }, "

        sharenamesJSON="$sharenamesJSON $localList"
    done

    sharenamesJSON="${sharenamesJSON%??}"

fi
sharenamesJSON="$sharenamesJSON ] "

acabarBucle=1; contador=$((contador+1))

# Comprobar workshares de servidores
while [ $acabarBucle -eq 1 ]
do
    linea=$(echo "$listing" | sed -n "${contador}p")
    if [ $contador -lt $lineTitle ]; then
        contador=$((contador+1))
        continue
    fi
    if [ -z "$linea" ]; then
        acabarBucle=0
        break
    fi
    
    contador=$((contador+1))
done

if [ $((contador - lineTitleServer)) -eq 2 ]; then
    servers=""
else
    servers=$(echo "$listing" | sed -n "$((lineTitleServer)),$((contador-2))"p)
fi

# crear JSON de servers
localCont=1
serversJSON=" [  "

if [ "$servers" != "" ]; then
    localVar=$(echo "$servers" | while read line
    do
        otherCont=1
        avanzar=0
        if [ $localCont -lt 2 ]; then
            localCont=$((localCont+1))
            continue
        fi
        for i in $(seq 0 ${#line}); do
            char=${line:i:1}
            if [ $avanzar -eq 1 ]; then
                if [ "$char" = " " ]; then
                    continue
                fi
            fi

            if [ "$char" = " " ] && [ "$otherCont" -lt 2 ]; then
                echo -n %
                otherCont=$((otherCont+1))
                avanzar=1
            fi

            if [ $avanzar -eq 1 ] && [ "$char" != " " ]; then
                avanzar=0
            fi

            echo -n $char
        done
        echo ""
    done)

    
    for linea in $localVar; do
        w1=$(echo $linea | cut -d "%" -f1) w1=\"$w1\"
        w2=$(echo $linea | cut -d "%" -f2) w2=\"$w2\"
        
        localList=" { "
        localList="$localList \"server\": $w1, "
        localList="$localList \"comment\": $w2 "
        localList="$localList }, "

        serversJSON="$serversJSON $localList"
    done

    serversJSON="${serversJSON%??}"

fi
serversJSON="$serversJSON ] "


acabarBucle=1; contador=$((contador+1))

# comprobar workshares de workgroups
while [ $acabarBucle -eq 1 ]
do
    linea=$(echo "$listing" | sed -n "${contador}p")
    if [ $contador -lt $lineTitle ]; then
        contador=$((contador+1))
        continue
    fi
    if [ -z "$linea" ]; then
        acabarBucle=0
        break
    fi
    
    contador=$((contador+1))
done

if [ $((contador - lineTitleWorkgroup)) -eq 2 ]; then
    workgroups=""
else
    workgroups=$(echo "$listing" | sed -n "$((lineTitleWorkgroup+1)),$((contador-1))"p)
fi

# crear JSON de workgroups
localCont=1
workgroupsJSON=" [  "

if [ "$" != "" ]; then
    localVar=$(echo "$workgroups" | while read line
    do
        otherCont=1
        avanzar=0
        if [ $localCont -lt 2 ]; then
            localCont=$((localCont+1))
            continue
        fi
        for i in $(seq 0 ${#line}); do
            char=${line:i:1}
            if [ $avanzar -eq 1 ]; then
                if [ "$char" = " " ]; then
                    continue
                fi
            fi

            if [ "$char" = " " ] && [ "$otherCont" -lt 2 ]; then
                echo -n %
                otherCont=$((otherCont+1))
                avanzar=1
            fi

            if [ $avanzar -eq 1 ] && [ "$char" != " " ]; then
                avanzar=0
            fi

            echo -n $char
        done
        echo ""
    done)

    
    for linea in $localVar; do
        w1=$(echo $linea | cut -d "%" -f1) w1=\"$w1\"
        w2=$(echo $linea | cut -d "%" -f2) w2=\"$w2\"
        
        localList=" { "
        localList="$localList \"server\": $w1, "
        localList="$localList \"comment\": $w2 "
        localList="$localList }, "

        workgroupsJSON="$workgroupsJSON $localList"
    done

    workgroupsJSON="${workgroupsJSON%??}"

fi
workgroupsJSON="$workgroupsJSON ] "


# mostrar resultados por pantalla
if [ $(echo "$sharenames" | wc -w) -eq 0 ] \
&& [ $(echo "$servers" | wc -w) -eq 0 ] \
&& [ $(echo "$workgroups" | wc -w) -eq 0 ]; then
    default_color; echo -n " > No hay recursos compartidos accesibles.\n"; default_color
else
    green_color; echo -en " > Recursos compartidos encontrados:\n"; default_color
    if [ $(echo "$sharenames" | wc -w) -ne 0 ]; then
        echo -en "\n$sharenames"
    fi
    if [ $(echo "$servers" | wc -w) -ne 0 ]; then
        echo "$servers"
    fi
    if [ $(echo "$workgroups" | wc -w) -ne 0 ]; then
        echo "$workgroups"
    fi
fi

# Probar acceso anónimo
smbclient \\\\$1\\tmp -U% > temp/anonymousLoginRES.txt -c "help; exit"
anonymousLoginRES=$(cat "temp/anonymousLoginRES.txt")
anonymousLoginREScont=$(echo "$anonymousLoginRES" | wc -w)
anonymousJSON=" [  "

if [ $anonymousLoginREScont -eq 0 ]; then
    green_color; echo -en "\n > Acceso a recursos compartidos de forma anónima no permitida.\n"; default_color
else
    green_color; echo -en "\n > Recursos compartidos accesibles de forma anónima (usuario anónimo)\n"; default_color
    echo -en " > $anonymousLoginREScont comandos ejecutables por usuario anónimo.\n"

    for elem in $anonymousLoginRES; do
        anonymousJSON="$anonymousJSON \"$elem\", "
    done
fi
anonymousJSON="${anonymousJSON%??}"
anonymousJSON="$anonymousJSON ] "

# Enumeracion de usuarios y dispositivos (impresoras)
enum4linux -a $IP > temp/enum4linuxRES.txt
sed -i 's/\\/\//g' temp/enum4linuxRES.txt 
totalenum="$(cat temp/enum4linuxRES.txt)"

lineEnumUsers=$(echo -e "$totalenum" | grep "Enumerating users using" -n | cut -d ":" -f1)
totallines=$(echo -e "$totalenum" | wc -l)
tailline=$(($totallines - $lineEnumUsers - 1))

linesUsers=$(echo -e "$totalenum" | tail -"$tailline")

lineEnumPrinters=$(echo -e "$linesUsers" | grep "Getting printer info" -n | cut -d ":" -f1)
linesUsers=$(echo "$linesUsers" | head -"$((lineEnumPrinters-2))")

userTypeList=$(echo "$linesUsers" | cut -d "/" -f2)
userList=$(echo "$linesUsers" | cut -d "/" -f2 | cut -d "(" -f1)
userList=$(echo "$userList" | awk '!seen[$0]++')

green_color; echo -en "\n > Enumeración de usuarios exitosa:\n"; default_color

userJSON=" [  "
for user in $userList; do
    echo "   - $user"
    userJSON="$userJSON \"$user\", "
done
userJSON="${userJSON%??}"
userJSON="$userJSON ] "

# crear JSON final con los resultados del protocolo
filename="enumedSamba.json"
PROT="SAMBA"

json_string='{ "protocolo": "'$PROT'", "version": "'$version'", "sharenames": '$sharenamesJSON', "servers": '$serversJSON', "workgroups": '$workgroupsJSON', "anonymousLoginCommands": '$anonymousJSON', "users": '$userJSON' }'
echo $json_string > "${filename}"

rm -rf temp