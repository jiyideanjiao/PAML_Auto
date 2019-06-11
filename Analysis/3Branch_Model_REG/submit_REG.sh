#!/bin/bash -ve
#SBATCH -p compute # partition (queue)
#SBATCH --export=ALL
#SBATCH -n 1

perl auto.pl gene.list > PAML.result.p.value.out
