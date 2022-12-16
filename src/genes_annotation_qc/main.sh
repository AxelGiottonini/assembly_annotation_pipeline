#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_annotation_qc.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir ./out/genes_annotation_qc
mkdir ./out/genes_annotation_qc/canu ./out/genes_annotation_qc/flye

sbatch ./src/genes_annotation_qc/busco.sh canu
sbatch ./src/genes_annotation_qc/busco.sh flye

mkdir ./out/genes_annotation_qc/canu/homologies ./out/genes_annotation_qc/flye/homologies
sbatch ./src/genes_annotation_qc/homologies.sh canu
sbatch ./src/genes_annotation_qc/homologies.sh flye

mkdir ./out/genes_annotation_qc/canu/salmon ./out/genes_annotation_qc/flye/salmon
sbatch ./src/genes_annotation_qc/salmon.sh canu 21
sbatch ./src/genes_annotation_qc/salmon.sh canu 31
sbatch ./src/genes_annotation_qc/salmon.sh flye 21
sbatch ./src/genes_annotation_qc/salmon.sh flye 31

mkdir ./out/genes_annotation_qc/canu/star ./out/genes_annotation_qc/flye/star
sbatch ./src/genes_annotation_qc/star.sh canu
sbatch ./src/genes_annotation_qc/star.sh flye