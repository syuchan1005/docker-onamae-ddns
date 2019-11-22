#!/bin/sh

if [ $# -ne 4 ]; then
  echo "Invalied args"
  exit 1
fi

userId=$1
passWord=$2
hostName=$3
domainName=$4

if [ -n "$hostName" ]; then
  fullDomain="$hostName.$domainName"
else
  fullDomain="$domainName"
fi

ipv4New="/var/local/DDNS_WAN_IPV4_new.txt"
ipv4Now="/var/local/DDNS_WAN_IPV4_now.txt"
modFile="/tmp/DDNS_modip.txt"
modResult="/tmp/DDNS_mod_result.txt"
modTmp1="/tmp/DDNS_mod_tmp1.txt"

echo "GET / HTTP/1.1\n\n" | nc $onamaeServer $ipCheckServerPort | sed -e "s/IPV4\: //" | sed -z "s/\n//g" >$ipv4New
if [ ! -f ${ipv4Now} ]; then
  cp $ipv4New $ipv4Now
fi
diff $ipv4New $ipv4Now
if [ $? = 0 ]; then
  echo "Same IP address. ($(cat $ipv4New))"
else
  (echo "LOGIN
USERID:$userId
PASSWORD:$passWord
.
MODIP
HOSTNAME:$hostName
DOMNAME:$domainName
IPV4:$(cat $ipv4New)
.
LOGOUT
.
") >$modFile
  openssl s_client -connect ${onamaeServer}:${modIpServerPort} -quiet <$modFile 2>/dev/null >$modResult
  cat $modResult | sed -e "/^000 COMMAND SUCCESSFUL$/d" -e "/^\.$/d" >$modTmp1
  if [ -s $modTmp1 ]; then
    logger -s -t $0 "(${fullDomain}) IP address update failed. See ${modResult}
$(cat $modResult)"
  else
    rm $modResult
    echo "(${fullDomain}) IP address updated successfully. ($(cat $ipv4Now))->($(cat $ipv4New))"
  fi
  rm $modTmp1
  rm $modFile
fi
mv -f $ipv4New $ipv4Now
chmod 600 $ipv4Now
