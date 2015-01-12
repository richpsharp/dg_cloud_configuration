#!/bin/bash

nodesFile=$1
pssh -i -t 0 -h $nodesFile "ps aux | grep dispynode.py | grep -v grep | sed 's/\s\+/,/g' | cut -d ',' -f2 | xargs kill -9"
pscp -t 0 -h $nodesFile -o /tmp/foo_bar run_dispynode.sh /home/hduser/workspace/invest-natcap.invest-3/
pssh -i -t 0 -h $nodesFile -o /tmp/foo_bar 'cd /home/hduser/workspace/invest-natcap.invest-3/; ./run_dispynode.sh'
