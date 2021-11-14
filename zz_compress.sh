#!/bin/bash

graph_types="bi rand sf sw tree"

# Iterate the string variable using for loop
for i in $graph_types; do
    tar -czf $i.tar.gz $i
done
