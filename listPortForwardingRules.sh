#!/bin/bash
cloudmonkey set display csv
cat /dev/null > pflist.csv
cloudmonkey listPortForwardingRules filter=virtualmachinename,protocol,publicport,privateport,ipaddress > pflist.csv
