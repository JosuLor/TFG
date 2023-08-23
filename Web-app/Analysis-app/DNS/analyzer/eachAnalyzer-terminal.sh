#!/bin/bash

purple_color() { echo -en "\e[35m\e[1m"; }
green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
yellow_color() { echo -en "\e[33m\e[1m"; }
blue_color() { echo -en "\e[34m\e[1m"; }
orange_color() { echo -en "\e[38;5;208m\e[1m"; }
grey_color() { echo -en "\e[38;5;240m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

url=$1
purple_color; echo -e " \n####### Analizando: $url #######"; default_color;

# Conseguir codigo fuente html de la pagina web
curl -s -L -o curlout.html $url
var=$(cat curlout.html);

# Comprobar si la url contiene formularios
cuantosforms=$(echo -e "$var" | grep -o "<form" | wc -l)
if [ $cuantosforms -eq 0 ]; then
    echo -e " > No se han encontrado formularios \n"
    exit 1
fi

# Conseguir las lineas de inicio y fin de cada formulario para delimitar el string
lineasform_START=$(echo -e "$var" | grep -n "<form" | cut -d: -f1); lineasform_START=($lineasform_START)
lineasform_END=$(echo -e "$var" | grep -n "</form" | cut -d: -f1);  lineasform_END=($lineasform_END)
forms=""

# Separar y guardar los formularios de la pagina web en una lista
green_color; echo -e " > Encontrado(s) $cuantosforms formulario(s)\n"; default_color;
for ((i=0; i<$cuantosforms; i++)); do
    l1=${lineasform_START[$i]}
    l2=${lineasform_END[$i]}
    txt=$(echo "$var" | sed -n "$l1,$l2"p)
    forms+=("$txt")
done

# Recuperar las acciones de los formularios ya analizados (para despues no analizarlos otra vez)
globalactions=$(cat globalactions.txt)

localactions=()
localvulns=()
forms=("${forms[@]:1}")
for ((j=0; j<$cuantosforms; j++)); do
    form=${forms[$j]} 

    # Conseguir los nombres de los campos del formulario, corregir datos conseguidos y guardarlos en un array 
    names=$(echo -e "$form" | grep -Eo 'name=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^name=["'\'']|["'\'']$//')
    fieldnames=($names)
    for idx in "${!fieldnames[@]}"; do
        modified_element="${fieldnames[idx]%?}"     
        fieldnames[idx]="$modified_element"
    done
    
    # Conseguir el action del formulario
    action=$(echo -e "$form" | grep -Eo 'action=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^action=["'\'']|["'\'']$//')
    action=${action%?}
    if [ -z "$action" ]; then action="$url"; fi
    
    # Conseguir el method del formulario
    method=$(echo -e "$form" | grep "method")
    method=$(echo -e "$method" | grep -Eo 'method=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^method=["'\'']|["'\'']$//')
    method=${method%?}
    if [ -z "$method" ]; then method="GET"; fi

    green_color
    echo -e " ### Formulario $((j+1))"
    echo -e " ### Action: $action ($method)"

    # Comprobar si el action ya ha aparecido en algun otro formulario anteriormente (para no analizarlo otra vez)
    if [ $(echo -e "$globalactions" | grep -x "$action" | wc -l) -ne 0 ]; then
        grey_color; echo -e " ### El action ya se ha analizado\n"; default_color;
        continue
    fi

    # Añadir el action al array de actions analizadas
    echo "$action" >> globalactions.txt
    
    # Si el formulario no tiene campos, no se analiza
    if [ ${#fieldnames[@]} -eq 1 ] || [ ${#fieldnames[@]} -eq 0 ]; then
        grey_color; echo -e " > El formulario no tiene campos\n"; default_color;
        continue
    fi

    # Analizar cada campo del formulario
    localparamvulns=()
    for fieldname in "${fieldnames[@]}"; do
        param="${fieldname}=XSS"
        default_color; echo -en " > Testing form field: $param";

        # Lanzar xsser, dependiendo del método del formulario
        if [ "$method" == "GET" ] || [ "$method" == "get" ]; then
            xsser -u $url?$param > xsserout.txt
        else
            xsser -u $url -p $param > xsserout.txt
        fi
        res=$(cat xsserout.txt)

        # Comprobar si se ha encontrado vulnerabilidad XSS
        if [ $(echo -e "$res" | grep "Successful: 1" | wc -l) -eq 0 ]; then
            grey_color; echo -e " > No se ha encontrado XSS"; default_color;
        else
            payload=$(echo -e "$res" | grep "Payload:" | cut -d "=" -f 2-)
            green_color; echo -e " > Se ha encontrado posible XSS"; orange_color; echo -e "   field: $fieldname || Payload: $payload\n"; default_color;
            localparamvulns+=( '{ "param": "'$param'", "payload": "'$payload'" }' )
        fi

    done

    # Añadir vulnerabilidades encontradas con el payload encontrado al array de vulnerabilidades
    if [ ${#localparamvulns[@]} -ne 0 ]; then
        localvulns+=( '{ "url": "'$url'", "action": "'$action'", "method": "'$method'", "vulns": ['$(IFS=,; echo "${localparamvulns[*]}")'] }' )
    fi
done

# Añadir las vulnerabilidades encontradas al fichero de resultados .json
for localvuln in "${localvulns[@]}"; do echo "$localvuln" >> temp-vulns.json; done

exit 0