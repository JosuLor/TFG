#!/bin/bash

cd Analysis-app/DNS

green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
purple_color() { echo -en "\e[35m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

# Variables y configuraciones locales
host=$1
rm -rf temp; mkdir temp

# Comprobar conexion con el dominio
echo -e "\n[] PROBANDO CONEXION CON EL DOMINIO $host\n\n"
ping -c 3 $host > temp/ping-out.txt 2> /dev/null
pingRES=$(cat "temp/ping-out.txt")
pingRES=$(echo "$pingRES" | grep "0% packet loss" | wc -w)

if [ $pingRES -eq 0 ]; then
    echo -en " <=="; red_color; echo -en " ERROR. Dominio de destino no alcanzable: $host"; default_color; echo -en " ==> \n"
    echo -e "\n > Recomendaciones:"
    echo -e "      Revise que el dominio proporcionado sea correcto"
    echo -e "      Compruebe que el dominio objetivo esté disponible\n"
    exit 3
else
    green_color; echo -en " > Host alcanzado (·|· en línea ·|·): $host\n\n"; default_color
fi

# Obtener y detectar IP asociada al dominio
nslookupRES=$(nslookup $host | awk '/Address/ {if (++count == 2) print}' | cut -d " " -f 2-)
if [ "$nslookupRES" == "" ]; then
    red_color; echo -e " > No se han encontrado direcciones IP asociadas al dominio $host\n"; default_color
else 
    green_color; echo -e " > Dirección IP asociada al dominio $host: $nslookupRES\n"; default_color
fi

# Enumeracion de servicios DNS mediante DNSenum
echo -e "[] ENUMERACION Y DESCUBRIMIENTO DNS\n"
dnsenum $host --enum -f ../wordlists/dns-wordlist.txt -noreverse > temp/dnsenum-out.txt 2> /dev/null
dnsinfo=$(cat "temp/dnsenum-out.txt")
dnsinfolength=$(echo -e "$dnsinfo" | wc -l)

# Conseguir lineas de inicio y fin de cada seccion para parsear
lineNameservers=$(echo -e "$dnsinfo" | grep -x "Name Servers:" -n | cut -d ":" -f1 | head -1)
lineMailservers=$(echo -e "$dnsinfo" | grep -x "Mail (MX) Servers:" -n | cut -d ":" -f1 | head -1)
lineZonetransfers=$(echo -e "$dnsinfo" | grep -x "Trying Zone Transfers and getting Bind Versions:" -n | cut -d ":" -f1 | head -1)
lineBruteforce=$(echo -e "$dnsinfo" | grep "Brute forcing" -n | cut -d ":" -f1 | head -1)
lastpart=$(echo -e "$dnsinfo" | tail -n $((dnsinfolength-lineBruteforce-2)))

lineWhoisqueries=$(echo "$lastpart" | while read line
    do
        if [ -z "$line" ]; then
            echo "$lastpart" | grep -x "$line" -n | cut -d ":" -f1 | head -1
            break 
        fi
    done)

lineBruteforce=1
purple_color; echo -e "Nombre de Servidor (A):\n=============================" ; default_color
nameServers=$(echo -e "$dnsinfo" | sed -n "$((lineNameservers+3)),$((lineMailservers-2))"p | cut -d " " -f1 | sed -e 's/\x1B\[[0-9;]*[a-zA-Z]//g')
echo -e "$nameServers\n"
purple_color; echo -e "Servidores de Correo (MX):\n============================="; default_color
mailServers=$(echo -e "$dnsinfo" | sed -n "$((lineMailservers+3)),$((lineZonetransfers-2))"p | cut -d " " -f1 | sed -e 's/\x1B\[[0-9;]*[a-zA-Z]//g')
echo -e "$mailServers\n"
purple_color; echo -e "Subdominios descubiertos:\n============================="; default_color
subdomains=$(echo -e "$lastpart" | sed -n "$((lineBruteforce)),$((lineWhoisqueries))"p | cut -d " " -f1 | sed -e 's/\x1B\[[0-9;]*[a-zA-Z]//g')
echo -e "$subdomains\n"

# crear JSON final con los resultados del protocolo
filename="enumedDNS.json"
PROT="DNS"

json_nameServers=" [  "
for servername in $nameServers; do
    json_nameServers="$json_nameServers \"$servername\", "
done
json_nameServers="${json_nameServers%??}"; json_nameServers="$json_nameServers ] "

json_mailServers=" [  "
for mailserver in $mailServers; do
    json_mailServers="$json_mailServers \"$mailserver\", "
done
json_mailServers="${json_mailServers%??}"; json_mailServers="$json_mailServers ] "

json_subdomains=" [  "
for subdomain in $subdomains; do
    json_subdomains="$json_subdomains \"$subdomain\", "
done
json_subdomains="${json_subdomains%??}"; json_subdomains="$json_subdomains ] "

json_string='{ "protocolo": "'$PROT'", "host": "'$host'", "ip_host": "'$nslookupRES'", "nameServers": '$json_nameServers', "mailServers": '$json_mailServers', "subdomains": '$json_subdomains' }'

echo $json_string > "${filename}"

rm -rf temp