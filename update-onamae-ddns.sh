#!/bin/sh

if [ $# -ne 5 ]; then
  echo "Invalied args"
  exit 1
fi

userId=$1
passWord=$2
hostName=$3
domainName=$4
newIP=$5

if [ -n "$hostName" ]; then
  fullDomain="$hostName.$domainName"
else
  fullDomain="$domainName"
fi

modResult="/tmp/DDNS_mod_result.txt"
modTmp1="/tmp/DDNS_mod_tmp1.txt"

(echo "LOGIN
USERID:$userId
PASSWORD:$passWord
.
MODIP
HOSTNAME:$hostName
DOMNAME:$domainName
IPV4:$newIP
.
LOGOUT
.
") | openssl s_client -connect ${onamaeServer}:${modIpServerPort} -quiet 2>/dev/null > $modResult
cat $modResult | sed -e "/^000 COMMAND SUCCESSFUL$/d" -e "/^\.$/d" >$modTmp1

if [ -s $modTmp1 ]; then
  logger -s -t $0 "(${fullDomain}) IP address update failed. See ${modResult} $(cat $modResult)"
else
  rm $modResult
  echo "(${fullDomain}) IP address updated successfully. ->($newIP)"
fi

rm $modTmp1
