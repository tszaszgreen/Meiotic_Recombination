#!/bin/bash

#SBATCH --job-name=Fish_UpDown
#SBATCH --mem-per-cpu=350G

for file in *.ctl; do
codeml ${file}
done
