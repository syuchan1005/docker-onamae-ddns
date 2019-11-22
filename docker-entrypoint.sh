#!/bin/sh

if [ -z "$domains" ]; then
  echo "require domains env"
  exit 1
fi

while :; do
  LENGTH=$(echo $domains | tr ',' '\n' | wc -l)
  for i in $(seq $LENGTH); do
    ELEMENT=$(echo $ARRAY | cut -d ',' -f $i)
    E_LEN=$(echo $ELEMENT | tr ':' '\n' | wc -l)
    if [ $E_LEN -ne 4 ]; then
      echo "'$ELEMENT' is invalied"
    else
      ./update-onamae-ddns.sh $(echo $ELEMENT | tr ':' ' ')
    fi
  done

  sleep $sleep
done
