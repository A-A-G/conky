#!/bin/bash

symbol=""
percent=false

while getopts :ps: opt
do
  case $opt in
    p) percent=true;;
    s) symbol=$OPTARG;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
  esac
done

if [ ! -z $symbol ]
then
  if ! $percent
  then
    curl -s "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=YUMJEZ0BTTYO0RX6" | jq '[."Time Series (Daily)"[]][0]."4. close" | tonumber*100+0.5|floor/100' | awk {'printf "% 6.2f",$1'}
  fi
else
  echo "Missing symbol (-s symbol)..."
  exit 1
fi

if $percent
then
  curl -s "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=YUMJEZ0BTTYO0RX6" | jq '.close=([."Time Series (Daily)"[]][0]."4. close" | tonumber)|.start=([."Time Series (Daily)"[]][1]."4. close" | tonumber)|(.close/.start-1)*10000+0.5|floor/100' | awk {'printf "% 5.2f",$1'}
fi
  
