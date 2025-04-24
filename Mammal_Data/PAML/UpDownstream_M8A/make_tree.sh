#!/bin/bash

for file in *.phy; do
base_name="${file%%.*}"
fasttree -nt ${file} > ${base_name}.tree
done
