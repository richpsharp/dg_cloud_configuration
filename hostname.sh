#!/bin/bash
MAC=$(/sbin/ifconfig eth0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')

echo "Getting host name."

HOSTNAME="`wget -q -O - http://ncp-skookum.stanford.edu/~mlacayo/hostname.php?mac=$MAC`"

echo "The host name is " $HOSTNAME

echo "Host name retrieved."
