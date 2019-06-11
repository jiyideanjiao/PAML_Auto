#!/bin/bash -ve

for i in `ls *.aln`
do
id=$(basename $i .aln)
perl pal2nal.pl $i $id.nuc -output fasta -nogap > $id.fas
done;

