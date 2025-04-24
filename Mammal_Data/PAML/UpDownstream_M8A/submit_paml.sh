#!/bin/bash
#SBATCH --job-name=Mammal_M8A  # Job name
#SBATCH --output=codeml_%A_%a.out  # Output file for each task
#SBATCH --error=codeml_%A_%a.err   # Error file for each task
#SBATCH --array=0-3
#SBATCH --mem=50G         # Memory per task


list=(${PWD}/*.ctl)

codeml ${list[$SLURM_ARRAY_TASK_ID]}


