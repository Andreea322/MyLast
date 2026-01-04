#!/bin/bash


LOGS="/var/log/auth.log /var/log/auth.log.[1-4]"


grep "pam_unix(login:session): session" $LOGS 2>/dev/null | while read line
do
  
  user=$(echo "$line" | awk '{for(i=1;i<=NF;i++) if($i=="user") print $(i+1)}')

  
  terminal=$(echo "$line" | grep -o 'TTY=[^ ;]*' | cut -d= -f2)
  [ -z "$terminal" ] && terminal="LOCAL"

  
  ip=$(echo "$line" | grep -oE 'from [0-9.]*' | awk '{print $2}')
  [ -z "$ip" ] && ip="N/A"

  
  echo "USER=$user | TERMINAL=$terminal | IP=$ip"
done
