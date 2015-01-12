#!/bin/bash
echo "#### Stopping iptables ####"
# drop iptables / firewall
sshpass -p "Bec8uheT" pssh -A -t 0 -h $1 -l root -o /tmp/foo_bar /etc/init.d/iptables stop
