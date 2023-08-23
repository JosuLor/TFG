#!/bin/bash

if [ $# -eq 0 ]; then
    cd Analysis-app/DNS/analyzer
fi

rm -f globalactions.txt
rm -f curlout.html
rm -f xsserout.txt
rm -f out-sorted-https.txt