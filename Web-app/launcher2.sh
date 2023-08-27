#!/bin/bash

purple_color() { echo -en "\e[35m\e[1m"; }
green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
yellow_color() { echo -en "\e[33m\e[1m"; }
blue_color() { echo -en "\e[34m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

help() {
  echo -e " 
          Mostrar ayuda: ./launcher.sh -h

          Uso: dos modos \n
            > Modo interactivo: ./launcher.sh -it
                [] Target IP: proporcionar IP obligatoriamente
                  ...
                [] El resto de opciones se pedirán por teclado secuencialmente\n
            > Modo parametrizado: ./launcher.sh --ip IP
                --ftp                 | Analisis basico de FTP
                --sql                 | Analisis basico de MySQL
                --samba               | Analisis basico de SAMBA
                --ssh                 | Analisis basico de SSH
                --dns DOMAIN          | Analisis de dominio
                --xssurl URL          | Analisis de XSS a URL
                --xssdom DOMAIN       | Analisis de XSS a todo el dominio
                --noshow              | Mostrar pero no confirmar la configuracion seleccionada\n"
}

modo_interactivo() {
  purple_color; echo -e "\n==============================\n || >> MODO INTERACTIVO << || \n==============================\n"; default_color
  echo -en " > Introduzca la IP de la máquina objetivo: "; green_color; read IP; default_color;
  if [[ $IP == "" ]]; then default_color; echo -en " > IP no introducida; saliendo...\n"; exit 3; fi
  
  red_color; echo -en " \n || ------ Protocolo SSH\n"; default_color;
  red_color; echo -en " || "; default_color; echo -en "Analisis basico (y/n): "; green_color; read SSH; default_color;
  if [[ $SSH != "y" ]] && [[ $SSH != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($SSH); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; SSH="n"; fi
  red_color; echo -en " ||\n";
  
  red_color; echo -en " || ------ Protocolo FTP\n"; default_color;
  red_color; echo -en " || "; default_color; echo -en "Analisis basico (y/n): "; green_color; read FTP; default_color;
  if [[ $FTP != "y" ]] && [[ $FTP != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($FTP); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; FTP="n"; fi
  red_color; echo -en " ||\n";

  red_color; echo -en " || ------ DOMINIO\n"; default_color;
  red_color; echo -en " || "; default_color; echo -en "Analisis basico (y/n): "; green_color; read DNS; default_color;
  if [[ $DNS != "y" ]] && [[ $DNS != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($DNS); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; DNS="n"; fi
  if [[ $DNS == "y" ]]; then red_color; echo -en " || "; default_color; echo -en "Introduzca el dominio: "; green_color; read DOM; default_color; fi
  red_color; echo -en " ||\n";
  
  if [[ $DNS == "y" ]]; then
    red_color; echo -en " || "; default_color; echo -en "Analisis de XSS a todo el dominio (y/n): "; green_color; read DOM_on_off; default_color;
    if [[ $DOM_on_off != "y" ]] && [[ $DOM_on_off != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($DOM_on_off); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; DOM_on_off="n"; fi
  fi

  red_color; echo -en " || "; default_color; echo -en "Analisis de XSS a URL (y/n): "; green_color; read URL_on_off; default_color;
  if [[ $URL_on_off != "y" ]] && [[ $URL_on_off != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($URL_on_off); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; URL_on_off="n"; fi
  if [[ $URL_on_off == "y" ]]; then red_color; echo -en " || "; default_color; echo -en "Introduzca la URL: "; green_color; read URL_xss; default_color; fi
  red_color; echo -en " ||\n";
  
  red_color; echo -en " || ------ Protocolo SAMBA\n"; default_color;
  red_color; echo -en " || "; default_color; echo -en "Analisis basico (y/n): "; green_color; read SAMBA; default_color;
  if [[ $SAMBA != "y" ]] && [[ $SAMBA != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($SAMBA); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; SAMBA="n"; fi
  red_color; echo -en " ||\n";

  red_color; echo -en " || ------ Servicio SQL (MySQL)\n"; default_color;
  red_color; echo -en " || "; default_color; echo -en "Analisis basico (y/n): "; green_color; read SQL; default_color;
  if [[ $SQL != "y" ]] && [[ $SQL != "n" ]]; then red_color; echo -en " || "; default_color; echo -en "Opcion no reconocida ($SQL); por defecto configurando a \"n\""; green_color; read EMPTY; default_color; SQL="n"; fi
}

mostrar_seleccion() {
  echo -e "\n > Configuracion seleccionada. ¿quieres continuar?\n"
  red_color; echo -en " > IP: "; green_color; echo -e "$IP"
  red_color; echo -en " > SSH: "; green_color; echo -e "$SSH"
  red_color; echo -en " > FTP: "; green_color; echo -e "$FTP"
  red_color; echo -en " > DNS: "; green_color; echo -e "$DNS"
  red_color; echo -en " > DOM: "; green_color; echo -e "$DOM"
  red_color; echo -en "     > XSS Dominio: "; green_color; echo -e "$DOM_on_off "; if [[ $DOM_on_off == "y" ]]; then red_color; echo -en " > XSS DOM: "; green_color; echo -e "$DOM"; fi
  red_color; echo -en "     > XSS URL: "; green_color; echo -en "$URL_on_off "; if [[ $URL_on_off == "y" ]]; then red_color; echo -en "($URL_xss)"; fi
  red_color; echo -en "\n > SAMBA: "; green_color; echo -e "$SAMBA"
  red_color; echo -en " > SQL: "; green_color; echo -e "$SQL"

  if [[ $NOSHOW == "n" ]]; then green_color; echo -en "\n > ¿Continuar? (s/n): "; default_color; read continuar; fi
}

FTP="n"
SQL="n"
SAMBA="n"
DNS="n"
SSH="n"
DOM=""
DOM_on_off="n"
URL_on_off="n"
NOSHOW="n"

# Comprobar si se ha pasado algun argumento, y mostrar ayuda en cierto caso
if [[ $# -eq 0 ]]; then
    help; exit 1
fi

# Mostrar ayuda si se introduce -h
if [[ $1 == "-h" ]]; then
  help; exit 2
elif [[ $1 == "-it" ]]; then
  modo_interactivo; mostrar_seleccion;
elif [[ $1 == "--ip" ]]; then

  purple_color; echo -e "\n================================\n || >> MODO PARAMETRIZADO << || \n================================\n"; default_color

  while [[ $# -gt 0 ]]; do
        case "$1" in
            --ip)
                IP="$2"
                shift 2
                ;;
            --ftp)
                FTP="y"
                shift
                ;;
            --sql)
                SQL="y"
                shift
                ;;
            --samba)
                SAMBA="y"
                shift
                ;;
            --ssh)
                SSH="y"
                shift
                ;;
            --dns)
                DNS="y"
                DOM="$2"
                shift 2
                ;;
            --xssurl)
                URL_on_off="y"
                URL_xss="$2"
                shift 2
                ;;
            --xssdom)
                DOM_on_off="y"
                DOM="$2"
                shift 2
                ;;
            --noshow)
                NOSHOW="y"
                shift
                ;;
            *)
                echo "Opción desconocida: $1"
                help
                exit 1
                ;;
        esac
  done

  mostrar_seleccion

else 
  help; exit 1
fi

default_color
# Limpiar ficheros de resultados de ejecuciones anteriores
Analysis-app/general/escoba.sh

# Comprobar conexion con la maquina objetivo
Analysis-app/general/ping-start.sh $IP > /dev/null 2> /dev/null
pingRes=$(echo $?)

if [ $pingRes -eq 0 ]; then
    green_color; echo -e "\n > La máquina $IP está en línea.\n"; default_color
else
    red_color; echo -e "\n > No se ha podido llegar a la máquina $IP.\n"; default_color
    exit 1
fi

# Detectar cuales de los analisis indicados por parametro son posibles (ver si existe el puerto correspondiente)
nmap -sV $IP > nmap-out.txt 2> /dev/null
ports=$(cat nmap-out.txt)

if [ "$FTP" == "y" ] && [ $(echo $ports | grep -w "21/tcp" | wc -l) -ne 0 ]; then dispatcher "ftp"; fi
if [ "$SSH" == "y" ] && [ $(echo $ports | grep -w "22/tcp" | wc -l) -ne 0 ]; then dispatcher "ssh"; fi
if [ "$SQL" == "y" ] && [ $(echo $ports | grep -w "3306/tcp" | wc -l) -ne 0 ]; then dispatcher "sql"; fi
if [ "$SAMBA" == "y" ] && [ $(echo $ports | grep -w "139/tcp" | wc -l) -ne 0 ]; then dispatcher "samba"; fi
if [ "$DNS" == "y" ]; then dispatcher "domain"; fi
if [ "$URL_on_off" == "y" ]; then dispatcher "xssurl"; fi
if [ "$DOM_on_off" == "y" ]; then dispatcher "xssdom"; fi

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
            ./Analysis-app/DNS/mainDNS.sh $DOM
            ;;
        "xssurl")
            echo -e "\n[] INICIANDO ANALISIS DE XSS A URL: $URL_xss ...\n"
            ./Analysis-app/DNS/analyzer/launcher.sh -d $DOM
            ;;
        "xssdom")
            echo -e "\n[] INICIANDO ANALISIS DE XSS A DOMINIO: $DOM ...\n"
            ./Analysis-app/DNS/analyzer/launcher.sh -d $DOM
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
}

# Crear fichero JSON con los resultados
Analysis-app/general/merge-json.sh $IP $DOM 2> /dev/null
green_color; echo -e "\n > Fichero JSON con los resultados creado.\n"; default_color

# Limpiar ficheros de resultados
Analysis-app/general/escoba.sh

exit 0