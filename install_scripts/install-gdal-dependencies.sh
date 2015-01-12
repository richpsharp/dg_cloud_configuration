#!/bin/bash
nodesFile=$1
echo "#### yum blas-devel ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install blas-devel
echo "#### yum lapack-devel ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install lapack-devel
echo "#### pip2.7 numpy ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install numpy
echo "#### pip2.7 scipy ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install scipy

echo "#### download GEOS source ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar wget http://download.osgeo.org/geos/geos-3.4.2.tar.bz2
echo "#### tar geos ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar tar xf geos-3.4.2.tar.bz2
echo "#### configure geos ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar 'cd geos-3.4.2; ./configure --enable-python'
echo "#### make geos ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'cd /home/hduser/geos-3.4.2/;make install'

echo "#### download gdal source ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar wget http://download.osgeo.org/gdal/1.11.1/gdal1111.zip
echo "#### unzip gdal ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar unzip gdal1111.zip

echo "#### configure ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar 'cd gdal-1.11.1/;./configure --with-geos'
echo "#### make ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'cd /home/hduser/gdal-1.11.1/;make install'

echo "#### export path /usr/local/lib ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'echo "export PATH=$PATH:/usr/local/lib" >> /etc/bashrc'
echo "#### export LD_LIBRARY_PATH ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> /etc/bashrc'

echo "#### pip2.7 gdal ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install gdal

echo "#### yum proj ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install proj
echo "#### yum proj-devel ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install proj-devel
