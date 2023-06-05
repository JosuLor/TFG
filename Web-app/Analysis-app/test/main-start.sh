#!/bin/bash

cd Analysis-app/test

pathMsfconsole=/opt/metasploit/msfconsole

$pathMsfconsole -q -r testMeta.rc > out.txt 2> /dev/null