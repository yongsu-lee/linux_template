#!/bin/bash

seed_para="100_51-100_"
graph_types="bi rand sf sw tree"

for i in $graph_types; do
    cd $i
    condor_submit submit -batch-name ${seed_para}_$i
    cd ..
done
