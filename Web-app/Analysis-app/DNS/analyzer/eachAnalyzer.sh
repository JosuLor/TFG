#!/bin/bash

cd Analysis-app/DNS/analyzer

purple_color() { echo -en "\e[35m\e[1m"; }
green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
yellow_color() { echo -en "\e[33m\e[1m"; }
blue_color() { echo -en "\e[34m\e[1m"; }
orange_color() { echo -en "\e[38;5;208m\e[1m"; }
grey_color() { echo -en "\e[38;5;240m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

# Funcion para outputear los resultados al proceso de Javascript en el servidor, para que el servidor pueda mostrarlos en tiempo real
echoar() {
    echo "{ \"url\": \"$currentURL\", 
            \"hasForms\": $currentHasForms, 
            \"isAlready\": $currentIsAlready, 
            \"action\": \"$currentAction\", 
            \"method\": \"$currentMethod\",
            \"formNumber\": $currentFormNumber, 
            \"formFieldNumber\": $currentFormFieldNumber, 
            \"formField\": \"$currentFormField\", 
            \"hasXSS\": \"$currentHasXSS\",
            \"END\": 0 }" >&1
}

globalactions=$(cat globalactions.txt)
url=$1

# Variables locales para outputearlo al proceso de Javascript en el servidor
currentURL="$url" 
currentHasForms=1           # 0 = no forms; 1 = has forms
currentAction=""            # action del formulario actual
currentMethod=""            # GET | POST
currentFormNumber=0         #  numero del formulario actual
currentFormFieldNumber=-1   # cuantos fields tiene el formulario
currentFormField=""         # nombre del field actualmente siendo analizado
currentIsAlready=0          # accion ya analizada (efecto blog) | 0 = not already analyzed; 1 = already analyzed
currentHasXSS=""            # "" = no xss; != "" -> el payload

# Conseguir codigo fuente HTML de la pagina web
curl -s -L -o curlout.html $url
var=$(cat curlout.html);

# Comprobar si la url contiene formularios
cuantosforms=$(echo -e "$var" | grep -o "<form" | wc -l)
lineasform_START=$(echo -e "$var" | grep -n "<form" | cut -d: -f1); lineasform_START=($lineasform_START)
lineasform_END=$(echo -e "$var" | grep -n "</form" | cut -d: -f1);  lineasform_END=($lineasform_END)
forms=""

if [ $cuantosforms -eq 0 ]; then
    currentHasForms=0
    echoar
    exit 1
fi

# Separar y guardar los formularios de la pagina web en una lista
for ((i=0; i<$cuantosforms; i++)); do
    l1=${lineasform_START[$i]}
    l2=${lineasform_END[$i]}
    txt=$(echo "$var" | sed -n "$l1,$l2"p)
    forms+=("$txt")
done

# Para cada formulario, ejecutar analisis
localactions=()
localvulns=()
forms=("${forms[@]:1}")
for ((j=0; j<$cuantosforms; j++)); do
    form=${forms[$j]} 

    # Conseguir nombre de los campos
    names=$(echo -e "$form" | grep -Eo 'name=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^name=["'\'']|["'\'']$//')
    fieldnames=($names)
    for idx in "${!fieldnames[@]}"; do
        modified_element="${fieldnames[idx]%?}" # Eliminar el último carácter
        fieldnames[idx]="$modified_element"      # Guardar la modificación en la misma posición
    done
    
    # Conseguir action
    action=$(echo -e "$form" | grep -Eo 'action=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^action=["'\'']|["'\'']$//')
    action=${action%?}
    if [ -z "$action" ]; then action="$url"; fi
    method=$(echo -e "$form" | grep "method")
    method=$(echo -e "$method" | grep -Eo 'method=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^method=["'\'']|["'\'']$//')
    method=${method%?}
    if [ -z "$method" ]; then method="GET"; fi

    green_color
    currentFormNumber=$((j+1))
    currentAction="$action"
    currentMethod="$method"

    # Comprobar si el action ya se ha analizado (si ya estaba en el fichero globalactions.txt)
    if [ $(echo -e "$globalactions" | grep -x "$action" | wc -l) -ne 0 ]; then
        currentIsAlready=1
        continue
    fi

    # Guardar el action para no analizarla otra vez
    localactions+=( "$action" )
    echo "$action" >> globalactions.txt
    
    # Si no hay campos, no se puede hacer XSS; pasar al siguiente formulario
    if [ ${#fieldnames[@]} -eq 1 ] || [ ${#fieldnames[@]} -eq 0 ]; then
        currentFormFieldNumber=0
        echoar
        continue
    else
        currentFormFieldNumber=${#fieldnames[@]}
    fi

    # Probar XSS con cada campo del formulario
    localparamvulns=()
    for fieldname in "${fieldnames[@]}"; do
        currentFormField="$fieldname"
        param="${fieldname}=XSS"

        # Ejecutar xsser, dependiendo del método del formulario (get/post)
        if [ "$method" == "GET" ] || [ "$method" == "get" ]; then
            #xsser -u $url?$param > xsserout.txt
            ./xsser -u $url?$param > xsserout.txt
        else
            #xsser -u $url -p $param > xsserout.txt
            ./xsser -u $url -p $param > xsserout.txt
        fi
        res=$(cat xsserout.txt)
        rm -f xsserout.txt

        # Comprobar si se ha encontrado XSS
        if [ $(echo -e "$res" | grep "Successful: 1" | wc -l) -eq 0 ]; then
            currentHasXSS=""
        else
            payload=$(echo -e "$res" | grep "Payload:" | cut -d "=" -f 2-)
            currentHasXSS=$payload
            localparamvulns+=( '{ "param": "'$param'", "payload": "'$payload'" }' )
        fi

        echoar
    done

    # Si se han encontrado vulnerabilidades, añadirlas al JSON local
    if [ ${#localparamvulns[@]} -ne 0 ]; then
        localvulns+=( '{ "url": "'$url'", "action": "'$action'", "method": "'$method'", "vulns": ['$(IFS=,; echo "${localparamvulns[*]}")'] }' )
    fi
done

# Escribir los resultados en ficheros temporales
for localaction in "${localactions[@]}"; do echo "$localaction" >> temp-actions.txt; done
for localvuln in "${localvulns[@]}"; do echo "$localvuln" >> temp-vulns.json; done

exit 0