#!/bin/bash

cd Analysis-app/general

nmap -sV $1 > nmap-out.txt
var=$(cat nmap-out.txt)
echo "$var" >&1

exit 0