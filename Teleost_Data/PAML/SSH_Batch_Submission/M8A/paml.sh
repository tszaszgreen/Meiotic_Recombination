#!/bin/bash

#SBATCH --job-name=M8A_Fish_Brain
#SBATCH --output=fish_brain_m8a.out
#SBATCH --mem-per-cpu=250G

#codeml all.ctl
codeml ccnd1.ctl
