#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=genes_annotation_qc.busco
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

ASSDIR=$1
INDIR=$( pwd )/out/genes_annotation/$ASSDIR
OUTDIR=$( pwd )/out/genes_annotation_qc/$ASSDIR

cd $OUTDIR

singularity exec \
    --bind $INDIR --bind . \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    busco \
        --cpu $SLURM_CPUS_PER_TASK \
        --mode proteins --lineage brassicales_odb10 \
        --in $INDIR/annotated.proteins.fasta \
        --out busco

cd -