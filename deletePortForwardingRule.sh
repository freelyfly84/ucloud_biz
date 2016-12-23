#!/bin/bash

apikey=`cat ~/.cloudmonkey/config | grep apikey | head -1 | awk '{print $3}'`
secretkey=`cat ~/.cloudmonkey/config | grep secretkey | head -1 | awk '{print $3}'`

cloudmonkey set apikey $apikey
cloudmonkey set secretkey $secretkey
cloudmonkey set display csv

IFS=,
sed 1d $1 | while read vm protocol public private ip
 do
        ipid=`python checkIpid.py $apikey $secretkey $ip`
        vmid=`cloudmonkey listVirtualMachines filter=id,displayname,name | grep -w $vm | awk -F , '{print $1}'`
        pfid=`cloudmonkey listPortForwardingRules ipaddressid=$ipid filter=id,publicport,virtualmachineid,protocol | grep -w $vmid | grep -w $public | grep -w $protocol | awk -F , '{print $4}'`

        cloudmonkey deletePortForwardingRule id=$pfid 
 done
