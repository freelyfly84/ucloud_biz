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
	vmid=`cloudmonkey listVirtualMachines filter=id,name,displayname | grep $vm | awk -F , '{print $1}'`
        cloudmonkey createPortForwardingRule ipaddressid=$ipid virtualmachineid=$vmid protocol=$protocol publicport=$public privateport=$private 
 done 


