#!/bin/bash
nodesFile=$1
echo "#### pip2.7 virtualenv ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install virtualenv 
echo "#### pip2.7 setuptools ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install setuptools
echo "#### pip2.7 cython ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install cython 
echo "#### pip2.7 nose ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install nose
echo "#### pip2.7 shapely ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install shapely

echo "#### yum python-distutils-extra ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install python-distutils-extra
echo "#### yum PyQt4 ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install PyQt4
echo "#### yum freetype-devel ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install freetype-devel
echo "#### yum libpng-devel ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install libpng-devel

echo "#### pip2.7 pyam ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install pyamg
echo "#### pip2.7 matplotlib ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install matplotlib
echo "#### pip2.7 mock ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install mock
echo "#### pip2.7 poster ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install poster
echo "#### yum goes-python ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install geos-python 
