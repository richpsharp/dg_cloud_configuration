#!/bin/bash
nodesFile=$1
echo "#### Creating Mount Directory ####"
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar yum -y install cifs-utils

echo "#### Creating Mount Directory ####"
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar mkdir /media/backblaze

echo "#### Change permissions ####"
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar chown hduser:hduser /media/backblaze

#echo "#### Mounting Backblaze to /media/backblaze ####"
#sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar 'mount -t cifs -o username=hduser,password=3g3n0m3,uid=hduser,gid=hduser //171.67.84.9/backblaze /media/backblaze'

echo "#### Mounting Backblaze to /media/backblaze ####"
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar 'echo "//ncp-geome.stanford.edu/backblaze /media/backblaze cifs credentials=/root/ncp-geome-backblaze-creds.txt,uid=hduser 0 0" >> /etc/fstab'

echo "#### Mounting Backblaze to /media/backblaze ####"
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar mount -a 

