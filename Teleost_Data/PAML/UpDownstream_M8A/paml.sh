#!/bin/bash
#SBATCH --job-name=Fish_M8A
#SBATCH --mem-per-cpu=50G

codeml SNPH.ctl
codeml DECR1.ctl 
