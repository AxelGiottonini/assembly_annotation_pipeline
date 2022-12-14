#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.update_gff
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

ASSDIR=$1
INDIR=$( pwd )/out/te_dynamics/$ASSDIR
OUTDIR=$( pwd )/out/te_dynamics/$ASSDIR
SIFDIR=/data/courses/assembly-annotation-course/containers2

if [[ "$ASSDIR" == "ref" ]]; then
    REFDIR=$( pwd )/out/te_dynamics/ref

    cd $REFDIR
    cp /data/courses/assembly-annotation-course/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta brassicaceae.fasta
    singularity exec --bind $REFDIR --bind $SIFDIR $SIFDIR/TEsorter_1.3.0.sif \
        TEsorter \
            brassicaceae.fasta \
            -db rexdb-plant \
            -p $SLURM_CPUS_PER_TASK
    cd - 

    exit 0
fi

cd $OUTDIR
singularity exec --bind $OUTDIR --bind $SIFDIR $SIFDIR/TEsorter_1.3.0.sif \
    TEsorter \
        $OUTDIR/TE.fasta \
        -db rexdb-plant \
        -p $SLURM_CPUS_PER_TASK
cd -
