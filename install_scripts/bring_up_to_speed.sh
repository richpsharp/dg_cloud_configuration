#!/bin/bash

./push_ssh_keys.sh $1 $2
./stop-iptables.sh $1
./hadoop-install-head.sh $1
./install-python-27.sh $1
./install-gdal-dependencies.sh $1
./install-luigi-dispy.sh $1
./install-invest-dependencies.sh $1
./install-mercurial-invest.sh $1
./mount_backblaze.sh $1
./start_dispynodes.sh $1 &

