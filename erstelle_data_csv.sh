#!/bin/bash

cat briefsammlung_trew.cmif.xml | 
xmlstarlet sel \
  -N 'tei=http://www.tei-c.org/ns/1.0' \
  -t \
     -o 'id,year,keywords,url' \
     -n \
     -m '//tei:correspDesc' \
     	-v 'concat("BV", substring-before(substring-after(@ref, "29-bv"), "-"))' \
	-o '%' \
     	-v 'substring(tei:correspAction/tei:date/@when, 1, 4)' \
	-o '%"' \
	-m 'tei:correspAction/tei:persName|tei:correspAction/tei:placeName' \
	   -v '.' \
	   -o '%' \
	   -b \
        -o '"%"' \
        -v '@ref' \
	-o '"' \
	-n | 
perl -pe 's/,/./g; s/%/,/g;' |
perl -pe 's/,","/","/' |
grep -P ',15[0-4].,' |
cat - > data.csv

