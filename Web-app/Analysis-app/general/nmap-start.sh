#!/bin/bash

cd Analysis-app/general

# nmap para conseguir puertos y servicios disponibles
nmap -sV $1 > nmap-out.txt
var=$(cat nmap-out.txt)
echo "$var" >&1

exit 0