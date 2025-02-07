#!/bin/bash

# ==============================================================================
# Author: Ali Farooq
# Description: The script continuously sends email to the system admin when ping is detected.
# Dependencies: tcpdump
# Version: 1.0
# ==============================================================================

# dst ip is the ip address of your machine

echo -e "Checking who is trying to ping this device...\n"
sudo stdbuf -oL tcpdump -i wlp0s20f3 'icmp[0] == 8 and dst 192.168.0.207' | tee ping_result.txt &

TCPDUMP_PID=$(pidof tcpdump)
#TCPDUMP_PID=$!
TCPDUMP_PPID=$(ps -o ppid= -p $TCPDUMP_PID)  # Get the parent PID

#echo "PID: $TCPDUMP_PID"

while true; do
  if [[ -s ping_result.txt ]]; then
    protocol=$(cat ping_result.txt | head -n1 | cut -d " " -f6)
    if [[ $protocol == "ICMP" ]]; then
      echo -e "ICMP packet detected!\n"
      break
    fi
  fi
done

#sudo kill -9 $TCPDUMP_PID
#sudo kill -9 $TCPDUMP_PPID

# Kill all related processes
sudo pkill -f "tcpdump -i wlp0s20f3"
sudo pkill -f "tee ping_result.txt"

python3 send_mail.py

if [ $? -eq 0 ]; then
  echo "Incident is reported to the admin."
else
  echo "Python script failed!"
fi

