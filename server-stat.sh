#!/bin/bash

# server-stats.sh
# A simple script to report system resource usage.

echo "===== SERVER STATS REPORT ====="
echo

# CPU Usage
echo ">> CPU Usage:"
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Total CPU Usage: $cpu_usage%"

echo

# Memory Usage
echo ">> Memory Usage:"
mem_info=$(free -m | grep Mem)
mem_total=$(echo $mem_info | awk '{print $2}')
mem_used=$(echo $mem_info | awk '{print $3}')
mem_free=$(echo $mem_info | awk '{print $4}')
mem_usage_percent=$(echo "scale=2; $mem_used/$mem_total*100" | bc)
echo "Total Memory: ${mem_total}MB"
echo "Used Memory : ${mem_used}MB"
echo "Free Memory : ${mem_free}MB"
echo "Memory Usage: ${mem_usage_percent}%"

echo

# Disk Usage
echo ">> Disk Usage:"
disk_info=$(df -h / | awk 'NR==2')
disk_used=$(echo $disk_info | awk '{print $3}')
disk_avail=$(echo $disk_info | awk '{print $4}')
disk_percent=$(echo $disk_info | awk '{print $5}')
echo "Disk Used   : $disk_used"
echo "Disk Free   : $disk_avail"
echo "Disk Usage  : $disk_percent"

echo

# Top 5 Processes by CPU Usage
echo ">> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 | column -t
echo

# Top 5 Processes by Memory Usage
echo ">> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6 | column -t
echo

echo "===== END OF REPORT ====="
