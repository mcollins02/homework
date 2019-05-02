#!/bin/bash
input_file="sub-est2017_all.csv"
columns="homework.out"
pop_column="popchange.out"
add_header="head_column"
add_header1="head_column1"

awk -F "," '{print $9","$10","$11","$20}' $input_file > $columns
awk -F "," '{print $20-$11}' $input_file > $pop_column
echo -e "POPCHANGE" | cat - $pop_column > $add_header
sed '$!s/$/,/' $add_header > $add_header1
paste -d' ' $add_header1 $columns
