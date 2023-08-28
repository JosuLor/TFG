#!/bin/bash

cd ./Analysis-app/

# Limpiar archivos de resultados de ejecuciones anteriores
if [[ $# -eq 0 ]]; then rm -f general/global.json; fi
rm -f SSH/enumedSSH.json
rm -f SAMBA/enumedSamba.json
rm -f FTP/enumedFTP.json
rm -f SQL/enumedSQL.json
rm -f DNS/enumedDNS.json
rm -f DNS/analyzer/temp-vulns.json

rm -f ../nmap-out.txt