#!/bin/bash

# variables
CPU_LIMIT=80
MEM_LIMIT=80
LOGFILE="/var/log/resource_monitor.log"
EMAIL="admin@email.com"

# get cpu and mem usage
CPU=$(top -bn1 | awk '/^%Cpu/ {print 100-$8}')
CPU_USE=${CPU%.*}

MEM_USE=$(free | awk '/Mem:/ {printf("%.0f", $3/$2*100)}')

# check usage limit
if ((CPU_USE > CPU_LIMIT || MEM_USE > MEM_LIMIT)); then
    # log usage with timestamp
    ts=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$ts | cpu: $CPU_USE% | memory: $MEM_USE%" >> "$LOGFILE"
fi
