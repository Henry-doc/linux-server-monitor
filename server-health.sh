
#!/bin/bash

echo "==============================="
echo "   LINUX SERVER HEALTH CHECK"
echo "==============================="

echo "Hostname"
      hostname

echo "Uptime"
      uptime

echo "Memory Usage"
       free -h

memory_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
echo "Memory percentage is $memory_usage%"

if [ "$memory_usage" -gt 80 ]; then
    echo "WARNING: Memory usage is high!"
else
     echo "Memory Status: OK"
fi

echo "Disk Usage"
       df -h /
       
       disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
echo "Disk percentage is $disk_usage%"

if [ "$disk_usage" -gt 80 ]; then
    echo "WARNING: Disk usage is high!"
else
     echo "Disk Status: OK"
fi 
echo "Top CPU Processes"
       ps -eo pid,comm,%cpu --sort=-%cpu | head -5

echo "CPU Usage"
      top -bn1 | grep "Cpu(s)"
      
      cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
      cpu_usage=$(awk "BEGIN {print 100 - $cpu_idle}")

echo "CPU Idle: $cpu_idle%"
echo "CPU Usage: $cpu_usage%"

if(( $(echo "$cpu_usage > 80" | bc -l) )); then
	echo "WARNING: CPU usage is high!"
else
	echo "CPU Status: OK"
fi
