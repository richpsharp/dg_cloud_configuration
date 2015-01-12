#!/bin/bash
nodesFile=$1
nodesFileFull=$2
echo "#### File with nodes ####"
echo $nodesFile

fileBasename=${nodesFileFull##*/}
remoteNodesPath="/home/hduser/"$fileBasename

echo "#### Remote path for nodes ####"
echo $remoteNodesPath

echo "#### Build Known Hosts from Nodes ####"
for NCPHOST in `cat $nodesFile`;
do
if ! grep -q "`ssh-keyscan ${NCPHOST}`" /home/hduser/.ssh/known_hosts; then
echo "#### Add ${NCPHOST} to known host ####"
ssh-keyscan ${NCPHOST} >> /home/hduser/.ssh/known_hosts;
echo "#### Copy ssh-key to node ####"
sshpass -p "3g3n0m3" ssh-copy-id -i ${NCPHOST};
fi
done

echo "#### Copy nodes list to node ####"
pscp -v -t 0 -h $nodesFile -e /tmp/foo_bar -o /tmp/foo_bak $nodesFileFull /home/hduser/

echo "#### Generate ssh-key for each node ####"
pssh -i -t 0 -h $nodesFile -o /tmp/foo_bar 'if [ ! -f /home/hduser/.ssh/id_rsa ]; then ssh-keygen -t rsa -N "" -f /home/hduser/.ssh/id_rsa; fi'

echo "#### Add ncp-egA to known hosts for each node ####"
for NCPHOST in `cat $nodesFile`;
do
pssh -i -t 0 -H ${NCPHOST} -o /tmp/foo_bar 'if [ -f /home/hduser/.ssh/known_hosts ];then if ! grep -q "`ssh-keyscan ncp-egA`" /home/hduser/.ssh/known_hosts;then ssh-keyscan ncp-egA >> /home/hduser/.ssh/known_hosts; fi; else ssh-keyscan ncp-egA >> /home/hduser/.ssh/known_hosts; fi'
done

# Need sshpass for future commands!
#echo "#### Copy sshpass repo ####"
#pscp -v -t 0 -h $nodesFile -e /tmp/foo_bar -o /tmp/foo_bak ./Downloads/sshpass-1.05-9.1.x86_64.rpm /home/hduser/

#echo "#### Add  sshpass repo ####"
#sshpass -p "Bec8uheT" pssh -A -i -t 0 -h $nodesFile -l root -o /tmp/foo_bar rpm -Uvh /home/hduser/sshpass-*rpm

# This will happen when each node adds each other node to known host list
#echo "#### Have each noded add itself to known hosts list ####"
#pssh -i -t 0 -h pssh-nodes-sub.txt -o /tmp/foo_bar 'ssh-keyscan `echo $HOSTNAME` >> /home/hduser/.ssh/known_hosts'

echo "#### Have each node send head node ssh-key ####"
for NCPHOST in `cat $nodesFile`;
do
if ! grep -q "`ssh-keyscan ${NCPHOST}`" /home/hduser/.ssh/authorized_keys; then
pssh -i -t 0 -H ${NCPHOST} -o /tmp/foo_bar 'sshpass -p "3g3n0m3" ssh-copy-id -i ncp-egA'
fi
done

echo "#### Have each node add each other node to known hosts list and send ssh-key ####"
for NCPHOST in `cat $nodesFileFull`;
do
pssh -i -t 0 -H ${NCPHOST} -o /tmp/foo_bar 'for NCPHOST in `cat $remoteNodesPath`; do if ! grep -q "`ssh-keyscan ${NCPHOST}`" /home/hduser/.ssh/known_hosts; then ssh-keyscan ${NCPHOST} >> /home/hduser/.ssh/known_hosts;sshpass -p "3g3n0m3" ssh-copy-id -i ${NCPHOST};fi;done'
done

echo "#### Setting ssh permissions ####"
# change ownership and permissions for ssh configuration
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar chmod 700 /home/hduser/.ssh
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar chmod 600 /home/hduser/.ssh/id_rsa
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar chmod 600 /home/hduser/.ssh/authorized_keys
sshpass -p "Bec8uheT" pssh -t 0 -A -h $nodesFile -l root -o /tmp/foo_bar chown -R hduser:hduser /home/hduser/.ssh

echo "#### Copying sshd_config file ####"
# copy ssh_config file as well????
sshpass -p "Bec8uheT" pscp -A -t 0 -h pssh-nodes-sub.txt -l root -o /tmp/foo_bar /home/hduser/sshd_config_copy /etc/ssh/sshd_config
