#!/bin/bash

URL=""
DOM=""
TARGET=""
# Conseguir parametros
while getopts "u:d:" opt; do
  case $opt in
    u)
      URL="$OPTARG"
      TARGET="$OPTARG"
      ;;
    d)
      DOM="$OPTARG"
      TARGET="$OPTARG"
      ;;
    \?)
      echo "Uso: ./launcher.sh [-u URL] [-d DOMINIO] \nUsar con dominio o con url, no con ambos"
      exit 1
      ;;
  esac
done

cd Analysis-app/DNS/analyzer
rm -f temp-vulns.json

if [ -z "$URL" ]; then
    
    # comprobar que el argumento es valido y que se puede llegar a el
    pingRes=$(ping -c 4 $TARGET)
    pingRes=$(echo $pingRes | grep "0% packet loss" | wc -l)
    if [ $(echo -e $pingRes) -eq 0 ]; then
        echo " > No se puede llegar a $TARGET"
        exit 1
    fi

    # enumerar y guardar las urls del dominio pasado como argumento
    ./test.sh $DOM terminal
    
    # recorrer las urls y lanzar el script de análisis con cada una de ellas
    while read line; do
        echo " > Analizando $line"
        ./eachAnalyzer-terminal.sh $line
    done < out-sorted-https.txt

else

    touch globalactions.txt
    # lanzar el script de análisis con la url unica pasada como argumento
    ./eachAnalyzer-terminal.sh $URL
fi

# eliminar los ficheros temporales
./clean-temp.sh terminal

# crear fichero vacio si no se han encontrado vulnerabilidades
if [ ! -f "temp-vulns.json" ]; then
    echo "{}" >> temp-vulns.json
fi

exit 0