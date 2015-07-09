import sys
import pandas as pd

dd = dict()
f = open("../data/appendix-b.csv")
for line in f:
    line = line.rstrip().split(",")
    dd[ line[0] ] = " ".join(line[1::])
f.close()

headers = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<kml xmlns="http://www.opengis.net/kml/2.2">',
    '<Document>'
]

footers = [
    '</Document>',
    '</kml>'
]

print "\n".join(headers)

df = pd.read_csv("../data/crash-merged-lat-lng.csv")

for row in df.iterrows():
    row = row[1]
    if row["TLA NAME"] != "Hamilton City":
        continue

    causes = [ row["CRASH DATE"] ]
    for elem in str(row["CAUSES"]).split():
        elem = elem.lower()
        if elem == "nan":
            continue
        elem = elem.replace("a","").replace("b","").replace("c","").replace("d","")
        if elem in dd:
            causes.append( dd[elem] )

    print '<Placemark>'
    print '<name></name>'
    print '<description>%s</description>' % ("<![CDATA[" + "<br>".join(causes) + "]]>")
    print '<Point>'
    print '<coordinates>%f,%f</coordinates>' % (row["LNG"], row["LAT"])
    print '</Point>'
    print '</Placemark>'

print "\n".join(footers)
