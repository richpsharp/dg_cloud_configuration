#!/bin/bash
# First script in setting up hduser for hadoop datanode slave
# This script should be run from slave host as root

# The following two lines are not needed if the user has been added through
# CentOS install
#adduser hduser
#passwd hduser
nodesFile=$1
echo "#### Add group and hduser to group ####"
# add a group hadoopgroup
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar groupadd hadoopgroup
# add hduser to group
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar usermod -g hadoopgroup hduser

#echo "####Update java packages####"
# update repositories to latest java. I found java-1.7.0_55 works well
# an older version of java that comes with CentOS does not have 'jps'
# command which is useful for hadoop status
#yum update java-1.7.0-openjdk*

#echo "####Installing newest java version####"
# install java
#yum -y install java-1.7.0-openjdk*

echo "#### Export Java Path ####"
# set system variable for java and add to path
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export PATH=$PATH:$JAVA_HOME" >> /home/hduser/.bashrc'

echo "#### Downloading Hadoop ####"
# download hadoop 2.2.0 from online apache source
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar wget http://archive.apache.org/dist/hadoop/core/hadoop-2.2.0/hadoop-2.2.0.tar.gz

echo "#### Unzip and extract Hadoop ####"
# extract hadoop package
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar tar xzvf hadoop-2.2.0.tar.gz

echo "#### Move Hadoop to /usr/local/hadoop ####"
# move hadoop to it's final location
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar mv hadoop-2.2.0 /usr/local/hadoop

# cleanup tar/zip file
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar rm -rf hadoop-2.2.0.tar.gz

# set permission for hduser on hadoop path
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar chown -R hduser:hadoopgroup /usr/local/hadoop

# create tmp directories for namenode/datanode edits/ hadoop stuff
# I suppose datanodes will not need namenode folder...
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar mkdir -p /home/hduser/hadoopspace/hdfs/namenode
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar mkdir -p /home/hduser/hadoopspace/hdfs/datanode
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar chown -R hduser:hadoopgroup /home/hduser/hadoopspace

echo "#### Export hadoop sys variables to .bashrc ####"

pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export HADOOP_INSTALL=/usr/local/hadoop" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export HADOOP_MAPRED_HOME=$HADOOP_INSTALL" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export HADOOP_COMMON_HOME=$HADOOP_INSTALL" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export HADOOP_HDFS_HOME=$HADOOP_INSTALL" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export YARN_HOME=$HADOOP_INSTALL" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export PATH=$PATH:$HADOOP_INSTALL/sbin" >> /home/hduser/.bashrc'
pssh -t 0 -h $nodesFile -l hduser -o /tmp/foo_bar 'echo "export PATH=$PATH:$HADOOP_INSTALL/bin" >> /home/hduser/.bashrc'

echo "#### Replace java path for hadoop ####"
#set variables for hadoop/etc/hadoop-env.sh
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar 'sed "s/export JAVA_HOME=.*/export JAVA_HOME=\/usr\/lib\/jvm\/jre\-1\.7\.0\-openjdk\.x86_64\//g" /usr/local/hadoop/etc/hadoop/hadoop-env.sh > /usr/local/hadoop/etc/hadoop/hadoop-env.sh.copy'

sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar mv /usr/local/hadoop/etc/hadoop/hadoop-env.sh.copy /usr/local/hadoop/etc/hadoop-env.sh
sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar chown -R hduser:hadoopgroup /usr/local/hadoop/etc/hadoop-env.sh

echo "#### Copying Hadoop Configuration files ####"
# copy config files
# not sure if I can do this here or have to wait to complete
# ssh hand shaking. Should have a general and maintained 
# location to copy config files from
sshpass -p "Bec8uheT" pscp -A -r -t 0 -h $nodesFile -l root -o /tmp/foo_bar /usr/local/hadoop/etc/hadoop/ /usr/local/hadoop/etc/hadoop/

sshpass -p "Bec8uheT" pssh -A -t 0 -h $nodesFile -l root -o /tmp/foo_bar chown -R hduser:hadoopgroup /usr/local/hadoop/etc/hadoop
