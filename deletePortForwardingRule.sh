#!/bin/bash

apikey='your apikey'
secretkey='your secretkey'

cloudmonkey set apikey $apikey
cloudmonkey set secretkey $secretkey
cloudmonkey set display csv

IFS=,
sed 1d $1 | while read vm protocol public private ip
 do
	ipid=`python checkIpid.py $apikey $secretkey $ip`
        vmid=`cloudmonkey listVirtualMachines filter=id,displayname,name | grep $vm | awk -F , '{print $1}'`
	pfid=`cloudmonkey listPortForwardingRules ipaddressid=$ipid filter=id,publicport,virtualmachineid | grep $vmid | grep $public | awk -F , '{print $3}'`

        cloudmonkey deletePortForwardingRule id=$pfid  
 done


