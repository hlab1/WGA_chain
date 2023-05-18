#!/bin/bash

cd ..
export WD=$PWD
cd $WD/scripts/
module load samtools/intel/1.14
mkdir $WD/resources/fasta/

for file in $WD/resources/fasta_raw/*.fasta; do
	out=$(echo $file | sed -e "s/chr\\.all\\.v2\\.0/genome_chr1-5/" -e "s/_raw//")
	samtools faidx $file chr1 chr2 chr3 chr4 chr5 > $out
	samtools faidx $out
done