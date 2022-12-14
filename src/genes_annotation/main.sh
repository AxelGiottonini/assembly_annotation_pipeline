#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_annotation.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir ./out/genes_annotation
mkdir ./out/genes_annotation/canu ./out/genes_annotation/flye

sbatch ./src/genes_annotation/maker.sh canu
sbatch ./src/genes_annotation/maker.sh flye
