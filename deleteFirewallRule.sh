#!/bin/bash

apikey=`cat ~/.cloudmonkey/config | grep apikey | head -1 | awk '{print $3}'`
secretkey=`cat ~/.cloudmonkey/config | grep secretkey | head -1 | awk '{print $3}'`

cloudmonkey set apikey $apikey
cloudmonkey set secretkey $secretkey
cloudmonkey set display csv

IFS=,
sed 1d $1 | while read start end cidrlist protocol ip
 do
        ipid=`python checkIpid.py $apikey $secretkey $ip`
        fwid=`cloudmonkey listFirewallRules ipaddressid=$ipid filter=cidrlist,id,startport,endport,protocol | grep -w $cidrlist | grep -w $start | grep -w $end | grep -w $protocol | awk -F , '{print $5}'`
        cloudmonkey deleteFirewallRule id=$fwid
 done
