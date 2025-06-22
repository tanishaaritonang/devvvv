#!/bin/bash

COUNT=5

echo -e "\n Top ${COUNT} IP addresses with the most requests:"
awk '{print $1}' logfile.txt | sort -nr | uniq -c | head -n ${COUNT} | awk '{print $2 " - " $1 " requests"}'

echo -e "\n Top ${COUNT} most requested paths: "
awk '{print $7}' logfile.txt | sort -nr | uniq -c |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n Top 5 response status codes: "
grep -oE ' [1-5][0-9]{2} ' logfile.txt | sort | uniq -c | sort -rn | awk '{print $2 " - " $1 " requests"}' |  head -n $COUNT 
