# crear JSON final con los resultados

cd ./Analysis-app/

filename="general/global.json"
company="Orbik"
description="Enumeración global de la máquina $1"
timestamp=$(date)
version="0.1"

json_ssh=$(cat SSH/enumedSSH.json); 
if [ "$json_ssh" == "" ]; then json_ssh="{}"; fi
json_samba=$(cat SAMBA/enumedSamba.json);
if [ "$json_samba" == "" ]; then json_samba="{}"; fi
json_ftp=$(cat FTP/enumedFTP.json);
if [ "$json_ftp" == "" ]; then json_ftp="{}"; fi
json_sql=$(cat SQL/enumedSQL.json);
if [ "$json_sql" == "" ]; then json_sql="{}"; fi
json_dns=$(cat DNS/enumedDNS.json);
if [ "$json_dns" == "" ]; then json_dns="{}"; fi

json_string='{ "IP": "'$1'", "Domain": "'$2'", "company": "'$company'", "description": "'$description'", "timestamp": "'$timestamp'", "version": "'$version'",
"ssh": '$json_ssh', "samba": '$json_samba', "ftp": '$json_ftp', "sql": '$json_sql', "dns": '$json_dns' }'

echo $json_string > "${filename}"