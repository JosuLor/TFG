#!/bin/bash

cd Analysis-app/FTP

green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
purple_color() { echo -en "\e[35m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

IP=$1
pathMsfconsole=/opt/metasploit/msfconsole
rm -rf temp; mkdir temp

sed 's/_IP_TARGET_/'$IP'/g' testFTP.rc > temp/temp_testFTP.rc

echo -e "\n[] PROBANDO EXISTENCIA DE SERVICIOS FTP...\n"
$pathMsfconsole -q -r "temp/temp_testFTP.rc" > "temp/out.txt" 2> /dev/null
var=$(cat "temp/out.txt")

version=$(echo -e "$var" | grep "FTP Banner" | cut -d "-" -f2)

if [ $(echo "$version" | wc -l) -eq 0 ]; then
    red_color; echo -en " > La máquina objetivo $IP no tiene servicios FTP.\n"; default_color
    exit 1
else
    green_color; echo -en " > Servicios FTP encontrados: " $version; default_color
    version="${version%?}"
fi

echo -e "\n\n[] PROBANDO MODO ANÓNIMO...\n"

isAnonymousEnabled=$(echo -e "$var" | grep "Anonymous FTP login not allowed" | wc -w)
if [ $isAnonymousEnabled -eq 0 ]; then isAnonymousEnabled="true"; else isAnonymousEnabled="false"; fi


anonUsers=$(echo -e "$var" | grep "Anonymous user account discovered:")
f_anonUsers=""
for user in $anonUsers; do
    localUser=$(echo "$user" | awk -F 'Anonymous user account discovered:' '{print $2}')
    f_anonUsers="$f_anonUsers$localUser\n"
done

anonRead=$(echo -e "$var" | grep -i "anonymous.*read.*enabled")
anonWrite=$(echo -e "$var" | grep -i "anonymous.*write.*enabled")

json_anonRead=" [  "
isAnonymousRead=$(echo -e "$var" | grep "Anonymous READ" | wc -w)
if [ $isAnonymousRead -ne 0 ]; then json_anonRead="$json_anonRead \"_GENERAL\", "; fi
for user in $anonRead; do
    json_anonRead="$json_anonRead \"$user\","
done
json_anonRead="${json_anonRead%??}"; json_anonRead="$json_anonRead ]"

json_anonWrite=" [  "
isAnonymousWrite=$(echo -e "$var" | grep "Anonymous WRITE" | wc -w)
if [ $isAnonymousWrite -ne 0 ]; then json_anonWrite="$json_anonWrite \"_GENERAL\", "; fi
for user in $anonWrite; do
    json_anonWrite="$json_anonWrite \"$user\","
done
json_anonWrite="${json_anonWrite%??}"; json_anonWrite="$json_anonWrite ]"

#if [ $anonRead -eq 0 ]; then anonRead="false"; else anonRead="true"; fi
#if [ $anonWrite -eq 0 ]; then anonWrite="false"; else anonWrite="true"; fi

isBouncable=$(nmap -sV -p 21 --script=ftp-bounce $IP | grep "bounce working!" | wc -w)
if [ $isBouncable -eq 0 ]; then isBouncable="false"; else isBouncable="true"; fi

# crear JSON final con los resultados del protocolo
filename="enumedFTP.json"
PROT="FTP"

json_anonUsers=" [  "
for user in $f_anonUsers; do
    json_anonUsers="$json_anonUsers \"$user\","
done
json_anonUsers="${json_anonUsers%??}"; json_anonUsers="$json_anonUsers ]"

json_string='{ "protocolo": "'$PROT'", "version": "'$version'", 
"isAnonymousEnabled": "'$isAnonymousEnabled'", "isBounceable": "'$isBouncable'", "anonymousUsers": '$json_anonUsers',
"anonymousRead": '$json_anonRead', "anonymousWrite": '$json_anonWrite' }'
echo $json_string > "${filename}"

rm -rf temp