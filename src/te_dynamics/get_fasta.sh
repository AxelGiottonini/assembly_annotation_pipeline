#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.get_fasta
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load UHTS/Analysis/BEDTools/2.29.2

ASSDIR=$1
INDIR=$( pwd )/out/assembly/$ASSDIR/
OUTDIR=$( pwd )/out/te_dynamics/$ASSDIR

bedtools getfasta -s -name \
    -fi $INDIR/assembly.polished.fasta \
    -bed $OUTDIR/TEanno.gff3 \
    -fo $OUTDIR/TE.fasta

module unload UHTS/Analysis/BEDTools/2.29.2