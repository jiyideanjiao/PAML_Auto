#!/bin/bash -ve

mkdir best_fas 1 2
mv *.fas best_fas/
grep ">" ./best_fas/*.fas > list
sed -i 's/^.*>//g' list
sort -u list > list.u
perl concatenate.0321.pl best_fas  1 2 list.u
cat ./2/* > sps_genes_concated.fas
sed -i '/^$/d' sps_genes_concated.fas

