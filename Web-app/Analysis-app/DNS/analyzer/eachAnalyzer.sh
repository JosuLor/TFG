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

#purple_color; echo -e " \n####### Analizando: $url #######"; default_color;
curl -s -L -o curlout.html $url
var=$(cat curlout.html);

cuantosforms=$(echo -e "$var" | grep -o "<form" | wc -l)
lineasform_START=$(echo -e "$var" | grep -n "<form" | cut -d: -f1); lineasform_START=($lineasform_START)
lineasform_END=$(echo -e "$var" | grep -n "</form" | cut -d: -f1);  lineasform_END=($lineasform_END)
forms=""

currentURL="$url" 
currentHasForms=1           # 0 = no forms; 1 = has forms
currentAction=""            # action del formulario actual
currentMethod=""            # GET | POST
currentFormNumber=0         #  numero del formulario actual
currentFormFieldNumber=-1   # cuantos fields tiene el formulario
currentFormField=""         # nombre del field actualmente siendo analizado
currentIsAlready=0          # accion ya analizada (efecto blog) | 0 = not already analyzed; 1 = already analyzed
currentHasXSS=""            # "" = no xss; != "" -> el payload

if [ $cuantosforms -eq 0 ]; then
#    echo -e " > No se han encontrado formularios \n"
    currentHasForms=0
    echoar
    exit 1
fi

#green_color; echo -e " > Encontrado(s) $cuantosforms formulario(s)\n"; default_color;
for ((i=0; i<$cuantosforms; i++)); do
    l1=${lineasform_START[$i]}
    l2=${lineasform_END[$i]}
    txt=$(echo "$var" | sed -n "$l1,$l2"p)
    forms+=("$txt")
done


localactions=()
localvulns=()
forms=("${forms[@]:1}")
for ((j=0; j<$cuantosforms; j++)); do
    form=${forms[$j]} 

    names=$(echo -e "$form" | grep -Eo 'name=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^name=["'\'']|["'\'']$//')
#echo ===========================
    fieldnames=($names)
    for idx in "${!fieldnames[@]}"; do
        modified_element="${fieldnames[idx]%?}" # Eliminar el último carácter
        fieldnames[idx]="$modified_element"      # Guardar la modificación en la misma posición
 #       echo $modified_element >> names.txt
    done
    
    action=$(echo -e "$form" | grep -Eo 'action=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^action=["'\'']|["'\'']$//')
    action=${action%?}
    
    if [ -z "$action" ]; then action="$url"; fi
    method=$(echo -e "$form" | grep "method")
    method=$(echo -e "$method" | grep -Eo 'method=["'\''][^"'\'' ]*["'\'']' | sed -E 's/^method=["'\'']|["'\'']$//')
    method=${method%?}
    if [ -z "$method" ]; then method="GET"; fi

    green_color
#    echo -e " ### Formulario $((j+1))"
    currentFormNumber=$((j+1))
#    echo -e " ### Action: $action ($method)"
    currentAction="$action"
    currentMethod="$method"

    if [ $(echo -e "$globalactions" | grep -x "$action" | wc -l) -ne 0 ]; then
#        grey_color; echo -e " ### El action ya se ha analizado\n"; default_color;
        currentIsAlready=1
        continue
    fi


#    if [[ " ${localactions[*]} " =~ " ${action} " ]]; then
#        grey_color; echo -e " ### El action ya se ha analizado\n"; default_color;
#        currentIsAlready=1
#        continue
#    fi
#    if [[ " ${globalactions[*]} " =~ " ${action} " ]]; then
#        grey_color; echo -e " ### El action ya se ha analizado\n"; default_color;
        
#        currentIsAlready=1
#        continue
#    fi
    

    localactions+=( "$action" )
    echo "$action" >> globalactions.txt
    
    if [ ${#fieldnames[@]} -eq 1 ] || [ ${#fieldnames[@]} -eq 0 ]; then
        currentFormFieldNumber=0
        echoar
        continue
    else
        currentFormFieldNumber=${#fieldnames[@]}
    fi

    localparamvulns=()
    for fieldname in "${fieldnames[@]}"; do
        currentFormField="$fieldname"
        param="${fieldname}=XSS"
#        echo -en " > Testing form field: $param";
        if [ "$method" == "GET" ] || [ "$method" == "get" ]; then
            xsser -u $url?$param > xsserout.txt
            #./xsser -u $url?$param > xsserout.txt
        else
            xsser -u $url -p $param > xsserout.txt
            #./xsser -u $url -p $param > xsserout.txt
        fi
        res=$(cat xsserout.txt)
        rm -f xsserout.txt

        if [ $(echo -e "$res" | grep "Successful: 1" | wc -l) -eq 0 ]; then
#            grey_color; echo -e " > No se ha encontrado XSS"; default_color;
            currentHasXSS=""
        else
            payload=$(echo -e "$res" | grep "Payload:" | cut -d "=" -f 2-)
            currentHasXSS=$payload
#            green_color; echo -e " > Se ha encontrado posible XSS"; orange_color; echo -e "   field: $fieldname || Payload: $payload\n"; default_color;
            localparamvulns+=( '{ "param": "'$param'", "payload": "'$payload'" }' )
        fi

        echoar
    done

    if [ ${#localparamvulns[@]} -ne 0 ]; then
        localvulns+=( '{ "url": "'$url'", "action": "'$action'", "method": "'$method'", "vulns": ['$(IFS=,; echo "${localparamvulns[*]}")'] }' )
    fi
done

echo ${#localparamvulns[@]} >> AAA.txt

for localaction in "${localactions[@]}"; do echo "$localaction" >> temp-actions.txt; done
for localvuln in "${localvulns[@]}"; do echo "$localvuln" >> temp-vulns.json; done

exit 0