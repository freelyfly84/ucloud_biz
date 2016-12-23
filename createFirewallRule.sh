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
        cloudmonkey createFirewallRule ipaddressid=$ipid protocol=$protocol cidrlist=$cidrlist startport=$start endport=$end
 done
