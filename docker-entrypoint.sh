#!/bin/sh

die() {
  exit 1
}

trap die TERM

if [ -z "$domains" ]; then
  echo "require domains env"
  exit 1
fi

while :; do
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
        "$(echo $ELEMENT | cut -d ':' -f 3)" \
        "$(echo $ELEMENT | cut -d ':' -f 4)"
    fi
  done

  sleep $sleep
done
