#!/bin/bash

cd Analysis-app/SSH

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

# Crear fichero de comandos de Metasploit temporal con la configuración de la máquina objetivo y usarlo
sed 's/_IP_TARGET_/'$IP'/g' testSSH.rc > temp/temp_testSSH.rc
$pathMsfconsole -q -r "temp/temp_testSSH.rc" > "temp/out.txt" 2> /dev/null
var=$(cat "temp/out.txt")

version=$(echo -e "$var" | grep "exploit" -n | cut -d ":" -f1)
version=$(echo -e "$var" | sed -n "$((version+1))"p | cut -d "-" -f 2-)

# Conseguir version de SSH
ssh-keyscan -t rsa $IP 2> temp/ssh-keyscan-version.txt > /dev/null
resVersion=$(cat "temp/ssh-keyscan-version.txt" | grep "SSH" | cut -d " " -f 3-)

# Comprobar existencia de servicios SSH
echo -e "\n[] PROBANDO EXISTENCIA DE SERVICIO SSH...\n"
if [ $(echo "$version" | wc -l) -eq 0 ]; then
    red_color; echo -en " > La máquina objetivo no tiene servicios SSH.\n"; default_color
    exit 1
else
    green_color; echo -en " > Servicios SSH encontrados:\n"; default_color; echo -e "$version";
    green_color; echo -e "\n > Servicios SSH encontrados (acortado):"; default_color; echo -e " $resVersion"
fi

# Conseguir algoritmos de cifrado, autenticacion y claves publicas de diferentes tipos
echo -e "\n[] ENUMERACION Y DESCUBRIMIENTO SSH...\n"
nmapRes=$(nmap -p 22 --script ssh2-enum-algos $IP)
nmapAuthMethodsRes=$(nmap -p 22 --script ssh-auth-methods $IP)

# RSA
ssh-keyscan -t rsa $IP > temp/ssh-key.txt 2> /dev/null
publicKey_rsa=$(cat "temp/ssh-key.txt")
publicKey_rsa=$(echo "$publicKey_rsa" | cut -d " " -f 3-)

# DSA
ssh-keyscan -t dsa $IP > temp/ssh-key-dsa.txt 2> /dev/null
publicKey_dsa=$(cat "temp/ssh-key-dsa.txt")
publicKey_dsa=$(echo "temp/$publicKey_dsa" | cut -d " " -f 3-)

# ECDSA
ssh-keyscan -t ecdsa $IP > temp/ssh-key-ecdsa.txt 2> /dev/null
publicKey_ecdsa=$(cat "temp/ssh-key-ecdsa.txt")
publicKey_ecdsa=$(echo "temp/$publicKey_ecdsa" | cut -d " " -f 3-)

# ED25519
ssh-keyscan -t ed25519 $IP > temp/ssh-key-ed25519.txt 2> /dev/null
publicKey_ed25519=$(cat "temp/ssh-key-ed25519.txt")
publicKey_ed25519=$(echo "temp/$publicKey_ed25519" | cut -d " " -f 3-)

# Mostrar informacion obtenida
if [ ${#publicKey_rsa} -gt 64 ]; then
    blue_color; echo -e " [ RSA ]"; purple_color; echo -e " > Clave publica obtenida:"; default_color; echo -e " $publicKey_rsa\n"
fi

if [ ${#publicKey_dsa} -gt 64 ]; then
    blue_color; echo -e " [ DSA ]"; purple_color; echo -e " > Clave publica obtenida:"; default_color; echo -e " $publicKey_dsa\n"
fi

if [ ${#publicKey_ecdsa} -gt 64 ]; then
    blue_color; echo -e " [ ECDSA ]"; purple_color; echo -e " > Clave publica obtenida:"; default_color; echo -e " $publicKey_ecdsa\n"
fi

if [ ${#publicKey_ed25519} -gt 64 ]; then
    blue_color; echo -e " [ ED25519 ]"; purple_color; echo -e " > Clave publica obtenida:"; default_color; echo -e " $publicKey_ed25519\n"
fi

ssh-keyscan -t rsa -v $IP > /dev/null 2> temp/ssh-key-debug.txt
debug=$(cat "temp/ssh-key-debug.txt")

# Conseguir lineas para despues de parsear la informacion obtenida
line_kex_algorithm=$(echo "$nmapRes" | grep "kex_algorithms:" -n | cut -d ":" -f1)
line_server_host_key_algo=$(echo "$nmapRes" | grep "server_host_key_algorithms:" -n | cut -d ":" -f1)
line_encryption_algo=$(echo "$nmapRes" | grep "encryption_algorithms:" -n | cut -d ":" -f1)
line_mac_algo=$(echo "$nmapRes" | grep "mac_algorithms:" -n | cut -d ":" -f1)
line_compression_algo=$(echo "$nmapRes" | grep "compression_algorithms:" -n | cut -d ":" -f1)
line_last=$(echo "$nmapRes" | grep "Nmap done: " -n | cut -d ":" -f1)
line_Supported=$(echo "$nmapAuthMethodsRes" | grep "Supported authentication methods" -n | cut -d ":" -f1)
line_last_Supported=$(echo "$nmapAuthMethodsRes" | grep "Nmap done: " -n | cut -d ":" -f1)

# Parsear informacion obtenida con los numeros de las lineas obtenidas 
algorithm=$(echo "$nmapRes" | sed -n "$((line_kex_algorithm+1)),$((line_server_host_key_algo-1))"p)
hostAlgorithm=$(echo "$nmapRes" | sed -n "$((line_server_host_key_algo+1)),$((line_encryption_algo-1))"p)
encryptionAlgo=$(echo "$nmapRes" | sed -n "$((line_encryption_algo+1)),$((line_mac_algo-1))"p)
macAlgo=$(echo "$nmapRes" | sed -n "$((line_mac_algo+1)),$((line_compression_algo-1))"p)
compressionAlgo=$(echo "$nmapRes" | sed -n "$((line_compression_algo+1)),$((line_last-1))"p)
clientCypher=$(echo "$debug" | grep "server->client" | awk -F 'server->client' '{print $2}')
serverCypher=$(echo "$debug" | grep "client->server" | awk -F 'client->server' '{print $2}')
supportedAuths=$(echo "$nmapAuthMethodsRes" | sed -n "$((line_Supported+1)),$((line_last_Supported-1))"p)

clientCypher="${clientCypher%?}"
serverCypher="${serverCypher%?}"

# Parsear informacion a listas
f_algorithm=""
for algo in $algorithm; do
    if [ "$algo" != "|" ]; then f_algorithm="${f_algorithm}"$'\n'"${algo}"; fi
done

f_hostAlgorithm=""
for algo in $hostAlgorithm; do
    if [ "$algo" != "|" ]; then f_hostAlgorithm="${f_hostAlgorithm}"$'\n'"${algo}"; fi
done

f_encryptionAlgo=""
for algo in $encryptionAlgo; do
    if [ "$algo" != "|" ]; then f_encryptionAlgo="${f_encryptionAlgo}"$'\n'"${algo}"; fi
done

f_macAlgo=""
for algo in $macAlgo; do
    if [ "$algo" != "|" ]; then f_macAlgo="${f_macAlgo}"$'\n'"${algo}"; fi
done

f_compressionAlgo=""
for algo in $compressionAlgo; do
    if [ "$algo" != "|" ] && [ "$algo" != "|_" ]; then f_compressionAlgo="${f_compressionAlgo}"$'\n'"${algo}"; fi
done

f_supportedAuths=""
for algo in $supportedAuths; do
    if [ "$algo" != "|" ] && [ "$algo" != "|_" ]; then f_supportedAuths="${f_supportedAuths}"$'\n'"${algo}"; fi
done

# Mostrar informacion obtenida
purple_color; echo -e " > Algoritmos Kex:"; default_color; echo "$f_algorithm"
purple_color; echo -e "\n > Algoritmos de clave host:"; default_color; echo "$f_hostAlgorithm"
purple_color; echo -e "\n > Algoritmos de cifrado:"; default_color; echo "$f_encryptionAlgo"
purple_color; echo -e "\n > Algoritmos de MAC:"; default_color; echo "$f_macAlgo"
purple_color; echo -e "\n > Algoritmos de compresion:"; default_color; echo "$f_compressionAlgo"
purple_color; echo -e "\n > Metodos de autenticacion soportados:"; default_color; echo "$f_supportedAuths"

purple_color; echo -e "\n > Cifrado cliente-servidor:"; default_color; echo "$clientCypher"
purple_color; echo -e "\n > Cifrado servidor-cliente:"; default_color; echo "$serverCypher"

# Enumerar sin intentar autenticarse usuarios del servicio con script de python
echo -e "\n[] ENUMERACION LIMITADA (wordlist) DE USUARIOS SSH...\n"
python3 testSSHenum.py -p 22 -t 25 -w ../wordlists/global-wordlist.txt $IP > temp/ssh-user-enum.txt
userEnumRes=$(cat "temp/ssh-user-enum.txt")
userEnumRes=$(echo "$userEnumRes" | grep "found!")

f_userEnum=""
for user in $userEnumRes; do
    if [ "$user" == "[+]" ] || [ "$user" == "found!" ]; then continue; fi
    f_userEnum="${f_userEnum}"$'\n'"${user}"
done

f_userEnum=$(echo -e "$f_userEnum" | sed -e 's/\x1b\[[0-9;]*m//g')
if [ "$f_userEnum" != "" ]; then
    green_color; echo -e "> Usuarios encontrados:"; default_color 
    echo "$f_userEnum"
else
    red_color; echo -e " > No se han encontrado usuarios"; default_color
fi

# crear JSON final con los resultados del protocolo
filename="enumedSSH.json"
PROT="SSH"

algoritmoJSON=" [  "
for algoritmo in $f_algorithm; do algoritmoJSON="$algoritmoJSON \"$algoritmo\", "; done
algoritmoJSON="${algoritmoJSON%??}"; algoritmoJSON="$algoritmoJSON ] "

hostAlgorithmJSON=" [  "
for algoritmo in $f_hostAlgorithm; do hostAlgorithmJSON="$hostAlgorithmJSON \"$algoritmo\", "; done
hostAlgorithmJSON="${hostAlgorithmJSON%??}"; hostAlgorithmJSON="$hostAlgorithmJSON ] "

encryptionAlgorithmJSON=" [  "
for algoritmo in $f_encryptionAlgo; do encryptionAlgorithmJSON="$encryptionAlgorithmJSON \"$algoritmo\", "; done
encryptionAlgorithmJSON="${encryptionAlgorithmJSON%??}"; encryptionAlgorithmJSON="$encryptionAlgorithmJSON ] "

macAlgorithmJSON=" [  "
for algoritmo in $f_macAlgo; do macAlgorithmJSON="$macAlgorithmJSON \"$algoritmo\", "; done
macAlgorithmJSON="${macAlgorithmJSON%??}"; macAlgorithmJSON="$macAlgorithmJSON ] "

compressionAlgorithmJSON=" [  "
for algoritmo in $f_compressionAlgo; do compressionAlgorithmJSON="$compressionAlgorithmJSON \"$algoritmo\", "; done
compressionAlgorithmJSON="${compressionAlgorithmJSON%??}"; compressionAlgorithmJSON="$compressionAlgorithmJSON ] "

authMethodsJSON=" [  "
for algoritmo in $f_supportedAuths; do authMethodsJSON="$authMethodsJSON \"$algoritmo\", "; done
authMethodsJSON="${authMethodsJSON%??}"; authMethodsJSON="$authMethodsJSON ] "

userEnumJSON=" [  "
for user in $f_userEnum; do userEnumJSON="$userEnumJSON \"$user\", "; done
userEnumJSON="${userEnumJSON%??}"; userEnumJSON="$userEnumJSON ] "

json_string='{ "protocolo": "'$PROT'", "version": "'$resVersion'", "versionFull": "'$version'",
"publicKey_rsa": "'$publicKey_rsa'", "publicKey_dsa": "'$publicKey_dsa'", "publicKey_ecdsa" : "'$publicKey_ecdsa'", "publicKey_ed25519" : "'$publicKey_ed25519'",
"algoritmo": '$algoritmoJSON', "algoritmosHostKey": '$hostAlgorithmJSON',
"algoritmosCifrado": '$encryptionAlgorithmJSON', "algoritmosMAC": '$macAlgorithmJSON', "algoritmosCompresion": '$compressionAlgorithmJSON',
"metodosAuth": '$authMethodsJSON',
"clientCypher": "'$clientCypher'", "serverCypher": "'$serverCypher'",
"userEnum": '$userEnumJSON' }'

echo $json_string > "${filename}"

rm -rf temp