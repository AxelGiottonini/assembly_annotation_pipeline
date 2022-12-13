#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_annotation.automated.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir ./out/te_annotation
mkdir ./out/te_annotation/canu ./out/te_annotation/flye
mkdir ./out/te_annotation/ref
mkdir ./out/te_annotation/canu/automated ./out/te_annotation/flye/automated

wget https://www.arabidopsis.org/download_files/Sequences/TAIR10_blastsets/TAIR10_cds_20110103_representative_gene_model
mv TAIR10_cds_20110103_representative_gene_model ./out/te_annotation/ref/

sbatch ./src/te_annotation/automated/edta.sh flye
sbatch ./src/te_annotation/automated/edta.sh canu