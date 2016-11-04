#!/usr/bin/python

import sys
import urllib2
import urllib
import hashlib
import hmac
import base64
#import os
import urlparse
import linecache
import json


baseurl = 'https://api.ucloudbiz.olleh.com/server/v1/client/api?'
apikey = sys.argv[1]
secretkey = sys.argv[2]
ip = sys.argv[3]
ipaddress = ip.strip()

def get_sig_request(request, secretkey, baseurl):
    request_str='&'.join(['='.join([k,urllib.quote_plus(request[k])]) for k in request.keys()])
    sig_str='&'.join(['='.join([k.lower(),urllib.quote_plus(request[k]).replace('+','%20').lower()])for k in sorted(request.iterkeys())])
    sig=urllib.quote_plus(base64.encodestring(hmac.new(secretkey,sig_str,hashlib.sha1).digest()).strip())
    return baseurl+request_str+'&signature='+sig

if apikey:
	request={}
	request['command']='listPublicIpAddresses'
	request['ipaddress']=ipaddress
	request['response']='json'
	request['apikey']=apikey
	
	req_url=get_sig_request(request, secretkey, baseurl)
	#print "Request URL = %s\n" % req_url
	res=urllib2.urlopen(req_url)
	parse = json.loads(res.read())
	for i in parse['listpublicipaddressesresponse']['publicipaddress']:	
 		print i['id']	
	res.close()
else:
	print "apikey none"
