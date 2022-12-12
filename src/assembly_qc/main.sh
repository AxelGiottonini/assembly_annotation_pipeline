#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=00:05:00
#SBATCH --job-name=assembly_qc.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

sbatch ./src/assembly_qc/busco.sh canu
sbatch ./src/assembly_qc/quast.sh canu
sbatch ./src/assembly_qc/busco.sh flye
sbatch ./src/assembly_qc/quast.sh flye

MERYL=$(sbatch ./src/assembly_qc/meryl.sh)
sbatch --dependency=afterok:${MERYL##* } ./src/assembly_qc/merqury.sh canu
sbatch --dependency=afterok:${MERYL##* } ./src/assembly_qc/merqury.sh flye
