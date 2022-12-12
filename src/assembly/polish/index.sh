#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --job-name=assembly.polish.index
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module add UHTS/Aligner/bowtie2/2.3.4.1;

ASSDIR=$1
INDIR=./out/assembly/$ASSDIR
OUTDIR=./out/assembly/$ASSDIR/polish

if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi

bowtie2-build \
    -f \
    --threads $SLURM_CPUS_PER_TASK \
    $INDIR/assembly.fasta \
    $OUTDIR/index