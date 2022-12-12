#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --job-name=assembly.polish.align
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module add UHTS/Aligner/bowtie2/2.3.4.1;

ASSDIR=$1
INDIR=./data/Illumina
OUTDIR=./out/assembly/$ASSDIR/polish

READS=($INDIR/*)
bowtie2 \
    -x $OUTDIR/index \
    -q \
    --sensitive-local \
    --threads $SLURM_CPUS_PER_TASK \
    -1 ${READS[0]} \
    -2 ${READS[1]} \
    -S $OUTDIR/alignment.sam