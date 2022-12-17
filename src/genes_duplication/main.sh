#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_duplication.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir ./out/genes_duplication
mkdir ./out/genes_duplication/canu ./out/genes_duplication/flye

for evalue in "1e-15" "1e-10" "1e-5" "1e-3" "1e-1" "1"; do
    mkdir ./out/genes_duplication/canu/$evalue ./out/genes_duplication/flye/$evalue
    CANU_DG=$( sbatch ./src/genes_duplication/dupgen.sh canu $evalue )
    FLYE_DG=$( sbatch ./src/genes_duplication/dupgen.sh flye $evalue )
    sbatch --dependency=afterok:${CANU_DG##* } ./src/genes_duplication/dupevents.sh canu C24 $evalue
    sbatch --dependency=afterok:${FLYE_DG##* } ./src/genes_duplication/dupevents.sh flye C24 $evalue
done