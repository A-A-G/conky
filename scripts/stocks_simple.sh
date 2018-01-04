#!/bin/bash
if [ ! -z "$1" ]; then
  curl -s "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$1&apikey=1Q4EHTJC0QOE8OOM" | jq '[."Time Series (Daily)"[]][0]."4. close" | tonumber'
fi
