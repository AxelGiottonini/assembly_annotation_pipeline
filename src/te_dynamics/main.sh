#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir ./out/te_dynamics
mkdir ./out/te_dynamics/canu ./out/te_dynamics/flye
mkdir ./out/te_dynamics/canu/plant ./out/te_dynamics/canu/brassicaceae 
mkdir ./out/te_dynamics/flye/plant ./out/te_dynamics/flye/brassicaceae

UPDATE_CANU=$(sbatch ./src/te_dynamics/update_gff.sh canu)
UPDATE_FLYE=$(sbatch ./src/te_dynamics/update_gff.sh flye)

FASTA_CANU=$(sbatch --dependency=afterok:${UPDATE_CANU##* } ./src/te_dynamics/get_fasta.sh canu)
FASTA_FLYE=$(sbatch --dependency=afterok:${UPDATE_FLYE##* } ./src/te_dynamics/get_fasta.sh flye)

sbatch --dependency=afterok:${FASTA_CANU##* } ./src/te_dynamics/te_sorter.sh canu
sbatch --dependency=afterok:${FASTA_FLYE##* } ./src/te_dynamics/te_sorter.sh flye
