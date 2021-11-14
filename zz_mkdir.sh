#!/bin/bash

rm -r {bi,rand,sf,sw,tree}
rm master.zip
rm -rf glmdag-master/

rm master_script.R

./pre_submit.sh

seed_para=100
simu_case="simu2"
size="large"
n_obs=150
path_par="TRUE"
n_multi=15
n_conti=10
n_ordin=25
graph_types="bi rand sf sw tree"
methods="mc mo mm"
eps_lam="0.4 0.5"
n_lams=30
iters=50

# Iterate the string variable using for loop
for i in $graph_types; do
    mkdir $i
    cp submit $i/
    cp run_R.sh $i/
    cp -r glmdag-master/ $i/ 
    cp master_script.R $i/
    echo "seed_para simu_case size n_obs graph_type n_multi n_conti n_ordin n_lams path_par" > $i/simu_info_common.txt
    echo "$seed_para $simu_case $size $n_obs $i $n_multi $n_conti $n_ordin $n_lams $path_par" >> $i/simu_info_common.txt
    #echo {1..50},{1..30} | sed 's/ /\n/g' > $i/queue_list    
    echo eps_lam_{0.4,0.5}_{mc,mo,mm},{51..100},{1..30} | sed 's/ /\n/g' > $i/queue_list    
    for j in $eps_lam; do
	for k in $methods; do
	    mkdir $i/eps_lam_${j}_$k
	    echo "eps_lam method" > $i/eps_lam_${j}_$k/simu_info.txt
	    echo $j $k >> $i/eps_lam_${j}_$k/simu_info.txt 
	    mkdir $i/eps_lam_${j}_$k/log
	done
    done
done
