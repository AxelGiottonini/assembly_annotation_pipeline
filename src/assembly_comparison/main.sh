#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=00:05:00
#SBATCH --job-name=assembly_comparison.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir $( pwd )/out/assembly_comparison

mkdir $( pwd )/out/assembly_comparison/canu ./out/assembly_comparison/flye
sbatch $( pwd )/src/assembly_comparison/mummer.sh canu
sbatch $( pwd )/src/assembly_comparison/mummer.sh flye
