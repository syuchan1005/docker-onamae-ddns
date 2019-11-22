#!/bin/sh

if [ -z "$domains" ]; then
  echo "require domains env"
  exit 1
fi

beforeIPPath="/tmp/beforeIP.txt"

while :; do
  nowIP=$(echo "GET / HTTP/1.1\n\n" | nc $onamaeServer $ipCheckServerPort | sed -e "s/IPV4\: //")
  touch $beforeIPPath
  beforeIP=$(cat $beforeIPPath)

  if [ "$nowIP" != "$beforeIP" ]; then
    LENGTH=$(echo $domains | tr ',' '\n' | wc -l)
    for i in $(seq $LENGTH); do
      ELEMENT=$(echo $domains | cut -d ',' -f $i)
      E_LEN=$(echo $ELEMENT | tr ':' '\n' | wc -l)
      if [ $E_LEN -ne 4 ]; then
        echo "'$ELEMENT' is invalied"
      else
        eval /onamae/update-onamae-ddns.sh \
          "$(echo $ELEMENT | cut -d ':' -f 1)" \
          "$(echo $ELEMENT | cut -d ':' -f 2)" \
          "'$(echo $ELEMENT | cut -d ':' -f 3)'" \
          "$(echo $ELEMENT | cut -d ':' -f 4)" \
          "$nowIP"
      fi
    done
  else
    echo "Same IP address. ($nowIP)"
  fi

  (echo $nowIP) > $beforeIPPath
  echo "Sleeping... $sleep"
  sleep $sleep
done
