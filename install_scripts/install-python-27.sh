#!/bin/bash
nodesFile=$1
echo "#### Yum groupinstall Development Tools ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y groupinstall "Development Tools"
echo "#### Yum install Dependencies ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
echo "#### Add /usr/local/lib to /etc/ld.so.conf ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'echo "/usr/local/lib" >> /etc/ld.so.conf'
echo "#### Download Python 2.7.6 Source ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar 'wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz'
echo "#### UnTar ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar tar xf /home/hduser/Python-2.7.6.tar.xz
echo "#### Compile Python 2.7.6 ####"
pssh -t 0 -h $nodesFile -o /tmp/foo_bar 'cd /home/hduser/Python-2.7.6/;./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"'
echo "#### Make ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'cd /home/hduser/Python-2.7.6/;make && make altinstall'
echo "#### Download and install ez_setup and pip ####"
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py;python2.7 ez_setup.py;easy_install-2.7 pip'
