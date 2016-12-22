#!/bin/bash
cloudmonkey set display csv
cat /dev/null > fwlist.csv
cloudmonkey listFirewallRules filter=cidrlist,protocol,startport,endport,ipaddress > fwlist.csv
