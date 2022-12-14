#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64MB
#SBATCH --time=10:00:00
#SBATCH --job-name=te_dynamics.update_gff
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

ASSDIR=$1
INDIR=$( pwd )/out/te_dynamics/$ASSDIR
OUTDIR=$( pwd )/out/te_dynamics/$ASSDIR
SIFDIR=/data/courses/assembly-annotation-course/containers2

cd $OUTDIR/plant
singularity exec --bind $OUTDIR --bind $OUTDIR/plant --bind $SIFDIR $SIFDIR/TEsorter_1.3.0.sif \
    TEsorter \
        $OUTDIR/TE.fasta \
        -db rexdb-plant \
        -p $SLURM_CPUS_PER_TASK
cd -

cd $OUTDIR/brassicaceae
singularity exec --bind $OUTDIR --bind $OUTDIR/brassicaceae --bind $SIFDIR $SIFDIR/TEsorter_1.3.0.sif \
    TEsorter \
        $OUTDIR/TE.fasta \
        -db /data/courses/assemblyannotation-course/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta \
        -p $SLURM_CPUS_PER_TASK
cd -