#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=16:00:00
#SBATCH --mem=64GB
#SBATCH --job-name=align

ref=$1
reffile=$2
Q=$3
Qfile=$4

module load mummer/intel/4.0.0rc1

cd $5
nucmer --maxmatch -c 100 -b 500 -l 50 -p $Q"_to_"$ref $Qfile $reffile
delta-filter -m -i 90 -l 100 $Q"_to_"$ref".delta" > $ref"_ref_"$Q"_Q.filtered.delta"

nucmer --maxmatch -c 100 -b 500 -l 50 -p $ref"_to_"$Q $reffile $Qfile
delta-filter -m -i 90 -l 100 $ref"_to_"$Q".delta" > $Q"_ref_"$ref"_Q.filtered.delta"


cd $6
$7 \
	-fwd $6$Q"_to_"$ref"_FWD.chain" \
	-rev $6$Q"_to_"$ref"_REV.chain" \
	$5$ref"_ref_"$Q"_Q.filtered.delta"

$7 \
	-fwd $6$ref"_to_"$Q"_FWD.chain" \
	-rev $6$ref"_to_"$Q"_REV.chain" \
	$5$Q"_ref_"$ref"_Q.filtered.delta"

