#!/bin/bash -ve

#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n 1

python autoPAML.py supergene.phy phylogeny.tre supergene.paml.out
