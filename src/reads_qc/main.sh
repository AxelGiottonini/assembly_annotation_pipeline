#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=00:05:00
#SBATCH --job-name=reads_qc.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

sbatch ./src/reads_qc/qc.sh Illumina
sbatch ./src/reads_qc/kmer_stats.sh Illumina
sbatch ./src/reads_qc/qc.sh pacbio
sbatch ./src/reads_qc/kmer_stats.sh pacbio
sbatch ./src/reads_qc/qc.sh RNAseq
sbatch ./src/reads_qc/kmer_stats.sh RNAseq