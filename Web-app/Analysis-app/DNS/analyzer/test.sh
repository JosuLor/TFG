#!/bin/bash

# sudo apt install golang-go

# sudo apt install hakrawler

# git clone https://github.com/lc/gau.git
# sudo apt install go
# go build cmd/gau/main.go
# mv main gau

if [ $# -eq 1 ]; then
    cd Analysis-app/DNS/analyzer
fi

purple_color() { echo -en "\e[35m\e[1m"; }
green_color() { echo -en "\e[32m\e[1m"; }
red_color() { echo -en "\e[31m\e[1m"; }
yellow_color() { echo -en "\e[33m\e[1m"; }
blue_color() { echo -en "\e[34m\e[1m"; }
default_color() { echo -en "\e[39m\e[0m"; }

rm -f globalactions.txt
touch globalactions.txt
rm -f temp-vulns.json

DOM=$1
echo https://$DOM | hakrawler > out-hakrawler.txt
cat out-hakrawler.txt | grep "$DOM" > inter-out-sorted-https.txt;
sed 's/\[.*\] \(.*\)/\1/' "inter-out-sorted-https.txt" > "out-sorted-https.txt"; 
var=$(cat out-sorted-https.txt); rm -f out-hakrawler.txt; rm -f inter-out-sorted-https.txt
lengthHTTPS=$(echo -e "$var" | wc -l)
if [ $# -eq 1 ]; then
    echo "$lengthHTTPS" >&1
fi

exit $lengthHTTPS

#if [ "$MODE" == "s" ]; then
#    echo " > Silent mode: " $DOM
#    echo https://$DOM | maingau > out-gau.txt
#    cat out-gau.txt | grep $DOM > out-sorted.txt
#elif [ "$MODE" == "a" ]; then
#    echo " > Aggressive mode: " $DOM
#    echo https://$DOM | hakrawler > out-hakrawler.txt
#    cat out-hakrawler.txt | grep $DOM > out-sorted.txt
#    rm out-hakrawler.txt
#    nHref=$(cat out-sorted.txt | grep -c "\[href\]")
#    nScript=$(cat out-sorted.txt | grep -c "\[script\]")
#fi