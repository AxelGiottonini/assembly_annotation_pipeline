#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --job-name=assembly.trinity
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Assembler/trinityrnaseq/2.5.1;

INDIR=./data/RNAseq
OUTDIR=./out/assembly/trinity

READS=($INDIR/*.fastq.gz)

Trinity \
    --seqType fq \
    --left ${READS[0]} \
    --right ${READS[1]} \
    --CPU $SLURM_CPUS_PER_TASK --max_memory 64G \
    --output $OUTDIR