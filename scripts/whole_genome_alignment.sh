#!/bin/bash

cd ..
export WD=$PWD
cd $WD/scripts

cd $1
files=$(ls -d $PWD/*.fasta)
reffile=$(echo $files | tr ' ' '\n' | grep $2)
ref=$(echo $reffile | sed -e "s/.*\\///" -e "s/\\.genome.*//")

cd $WD/scripts
mkdir -p $3
cd $3
deltafolder=$PWD
cd $WD/scripts

cd $WD/scripts
mkdir -p $4
cd $4
chainfolder=$PWD
cd $WD/scripts


rm *.out
rm *.err

for Qfile in $files; do
	if [[ $Qfile != $reffile ]]
	then
		Q=$(echo $Qfile | sed -e "s/.*\\///" -e "s/\\.genome.*//")
		echo $Q
		sbatch $WD/scripts/whole_genome_alignment.s $ref $reffile $Q $Qfile $deltafolder"/" $chainfolder"/" $WD/scripts/crossmap_delta_to_chain.pl
	fi
done