#!/bin/bash

IFS=$'\n'
NR=$'\r'
re='^[0-9]+$'
i=1

DATA=$(curl -s https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/cities/totals/sub-est2017_all.csv | LC_CTYPE=C tr -d $'\r')
# Smaller dataset for testing
#DATA=$(curl -s https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/cities/totals/sub-est2017_32.csv | tr -d $'\r')

HEADER="NAME,STNAME,CENSUS2010POP,POPESTIMATE2017,POPCHANGE"

for line in $DATA; do
  CITY="$(cut -d ',' -f9 <<< ${line})"
  STATE="$(cut -d ',' -f10 <<< ${line})"
  CENSUS="$(cut -d ',' -f11 <<< ${line})"
  ESTIMATE="$(cut -d ',' -f20 <<< ${line})"

  if [ $i == 1 ]; then
    echo $HEADER
    i=0
  else
    if ! [[ $CENSUS =~ $re ]]; then
       DIFF="-"
    else
       DIFF=$(echo "$CENSUS - $ESTIMATE" | bc)
    fi
    echo "${CITY},${STATE},${CENSUS},${ESTIMATE},${DIFF}"
  fi
done
