#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n 1

for i in `ls *.pml`
do
id=$(basename $i .pml)
python autoPAML.py $i phylogeny.tre $id.out
done;
