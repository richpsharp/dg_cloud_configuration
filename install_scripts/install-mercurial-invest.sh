#!/bin/bash
nodesFile=$1
echo "#### yum python-devel ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install python-devel
echo "#### yum python-docutils ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install python-docutils
echo "#### pip2.7 docutils ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar pip2.7 install docutils

echo "#### Create soft link path for PyQt4 ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'ln -s /usr/lib64/python2.6/site-packages/PyQt4/ /usr/local/lib/python2.7/site-packages/PyQt4'

echo "#### Create soft link path for sip.so ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'ln -s /usr/lib64/python2.6/site-packages/sip.so /usr/local/lib/python2.7/site-packages/sip.so'

echo "#### Download Mercurial 3.1.2 ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'wget http://mercurial.selenic.com/release/mercurial-3.1.2.tar.gz'
echo "#### Extract Mercurial ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'tar xvzf mercurial-3.1.2.tar.gz'
echo "#### Make Install Mercurial ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'cd mercurial-3.1.2/; make install'

echo "#### Create workspace directory ####"
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'mkdir /home/hduser/workspace'

echo "#### Clone InVEST-3 ####"
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'cd /home/hduser/workspace/; hg clone https://code.google.com/p/invest-natcap.invest-3/'

echo "#### Add largefiles ext to hgrc ####"
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "[extensions]" >> /home/hduser/workspace/invest-natcap.invest-3/.hg/hgrc' 
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "largefiles=" >> /home/hduser/workspace/invest-natcap.invest-3/.hg/hgrc' 

echo "#### hg up ####"
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'cd /home/hduser/workspace/invest-natcap.invest-3/;hg up' 
