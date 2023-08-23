#!/bin/bash

green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

# Repartir tareas a los scripts correspondientes
dispatcher() {
    case "$1" in
        "sql")
            echo -e "\n[] INICIANDO ENUMERACIÓN DE SERVICIOS SQL...\n"
            ./Analysis-app/SQL/mainSQL.sh $IP
            ;;
        "ftp")
            echo -e "\n[] INICIANDO ENUMERACIÓN DE SERVICIOS FTP...\n"
            ./Analysis-app/FTP/mainFTP.sh $IP
            ;;
        "samba")
            echo -e "\n[] INICIANDO ENUMERACIÓN DE SERVICIOS SAMBA...\n"
            ./Analysis-app/SAMBA/mainSAMBA.sh $IP
            ;;
        "ssh")
            echo -e "\n[] INICIANDO ENUMERACIÓN DE SERVICIOS SSH...\n"
            ./Analysis-app/SSH/mainSSH.sh $IP
            ;;
        "domain")
            echo -e "\n[] INICIANDO ANALISIS DE DOMINIO...\n"
            #./Analysis-app/DNS/mainDNS.sh $DOM
            ./Analysis-app/DNS/analyzer/launcher.sh -d $DOM
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
}

URL=""
DOM=""
TARGET=""

PING=false
DOMAIN=""
FTP=""
SAMBA=""
SQL=""
SSH=""

# Getopt para obtener los argumentos
args=$(getopt -l "ip:,domain:,ftp,sql,samba,ssh" -o "" -- "$@")
eval set -- "$args"

while true; do
  case "$1" in
    --ip)
      shift
      if [ -n "$1" ]; then
        IP="$1"
      else
        echo "La opción --ip requiere un argumento."
        exit 1
      fi
      shift
      ;;
    --domain)
      shift
      if [ -n "$1" ]; then
        DOM="$1"
      else
        echo "La opción --domain requiere un argumento."
        exit 1
      fi
      DOMAIN="true"
      shift
      ;;
    --ftp)
      FTP="true"
      shift
      ;;
    --sql)
      SQL="true"
      shift
      ;;
    --samba)
      SAMBA="true"
      shift
      ;;
    --ssh)
      SSH="true"
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Uso: ./launcher.sh --ip IP [--domain] [--ftp] [--sql] [--samba] [--ssh]"
      exit 1
      ;;
  esac
done

# Limpiar ficheros de resultados de ejecuciones anteriores
#Analysis-app/general/escoba.sh

# Comprobar conexion con la maquina objetivo
#Analysis-app/general/ping-start.sh $IP > /dev/null 2> /dev/null
pingRes=$(echo $?)

if [ $pingRes -eq 0 ]; then
    green_color; echo -e "\n > La máquina $IP está en línea.\n"; default_color
else
    red_color; echo -e "\n > No se ha podido llegar a la máquina $IP.\n"; default_color
    exit 1
fi

# Detectar cuales de los analisis indicados por parametro son posibles (ver si existe el puerto correspondiente)
#nmap -sV $IP > nmap-out.txt 2> /dev/null
ports=$(cat nmap-out.txt)

if [ "$FTP" == "true" ] && [ $(echo $ports | grep -w "21/tcp" | wc -l) -ne 0 ]; then dispatcher "ftp"; fi
if [ "$SSH" == "true" ] && [ $(echo $ports | grep -w "22/tcp" | wc -l) -ne 0 ]; then dispatcher "ssh"; fi
if [ "$SQL" == "true" ] && [ $(echo $ports | grep -w "3306/tcp" | wc -l) -ne 0 ]; then dispatcher "sql"; fi
if [ "$SAMBA" == "true" ] && [ $(echo $ports | grep -w "139/tcp" | wc -l) -ne 0 ]; then dispatcher "samba"; fi
if [ "$DOMAIN" == "true" ]; then dispatcher "domain"; fi

# Crear fichero JSON con los resultados
Analysis-app/general/merge-json.sh $IP $DOM 2> /dev/null
green_color; echo -e "\n > Fichero JSON con los resultados creado.\n"; default_color

# Limpiar ficheros de resultados
#Analysis-app/general/escoba.sh

exit 33