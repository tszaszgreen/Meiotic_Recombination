#!/bin/bash

module load coevol

coevol -d brcc3.fasta -t coevol_tree.txt -fixtimes -c mlh1_f.lht -dsom brcc3_whole

