#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --job-name=assembly_comparison.mummer
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module add UHTS/Analysis/mummer/4.0.0beta1

ASSDIR=$1
INPDIR=$( pwd )/out/assembly/$ASSDIR
OUTDIR=$( pwd )/out/assembly_comparison/$ASSDIR
REFDIR=/data/courses/assembly-annotation-course/references

cd $OUTDIR

nucmer \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFDIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
    $INPDIR/assembly.polished.fasta

mummerplot \
    -R $REFDIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
    -Q $INPDIR/assembly.polished.fasta \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    out.delta

cd -