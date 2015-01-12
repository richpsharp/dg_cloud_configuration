#!/bin/bash
nodesFile=$1
echo "#### Pip2.7 Luigi ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install luigi
echo "#### Pip2.7 Tornado ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install tornado 
echo "#### Pip2.7 Mechanize ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install mechanize
echo "#### Pip2.7 Dispy ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install dispy
