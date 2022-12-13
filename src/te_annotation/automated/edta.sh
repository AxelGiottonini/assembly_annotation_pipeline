#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=01-00:00:00
#SBATCH --job-name=te_annotation.automated.edta
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

ASSDIR=$1
INDIR=$( pwd )/out/assembly/$ASSDIR
OUTDIR=$( pwd )/out/te_annotation/$ASSDIR/automated
REFDIR=$( pwd )/out/te_annotation/ref
SIFDIR=/data/courses/assembly-annotation-course/containers2

cd $OUTDIR

singularity exec \
    --bind $INDIR --bind $OUTDIR --bind $REFDIR --bind $SIFDIR \
    $SIFDIR/EDTA_v1.9.6.sif \
    EDTA.pl \
        --genome $INDIR/assembly.polished.fasta \
        --species others \
        --step all \
        --cds $REFDIR/TAIR10_cds_20110103_representative_gene_model \
        --anno 1 \
        --threads $SLURM_CPUS_PER_TASK

cd -
