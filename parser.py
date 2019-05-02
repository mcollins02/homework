#!/usr/bin/python

import requests

csv = requests.get('https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/cities/totals/sub-est2017_all.csv').text.encode("utf-8")

f=open("output.csv","w")
for i, l in enumerate(csv.splitlines()):
    v = l.split(',')
    if i == 0:
        f.write("%s,%s,%s,%s,POPCHANGE\n" % (v[8],v[9],v[10],v[19]))
    else:
        if v[10].isdigit() and v[19].isdigit():
            diff = int(v[10]) - int(v[19])
        else:
            diff = "-"
        f.write("%s,%s,%s,%s,%s\n" % (v[8],v[9],v[10],v[19],diff))
f.close()
