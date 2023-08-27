#!/bin/bash

pingRES=$(ping -c 4 $1)
echo "$pingRES" >&1
if [ $(echo "$pingRES" | grep "0% packet loss" -w | wc -l) -ne 0 ]; then
    exit 0
else
    exit 99
fi