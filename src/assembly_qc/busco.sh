#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=assembly_qc.busco
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

ASSDIR=$1
INDIR=./out/assembly/$ASSDIR
OUTDIR=./out/assembly_qc/$ASSDIR

if ! [ -d ./out/ ]; then mkdir ./out/; fi
if ! [ -d ./out/assembly_qc/ ]; then mkdir ./out/assembly_qc/; fi
if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi
if ! [ -d $OUTDIR/busco ]; then mkdir $OUTDIR/busco; fi

singularity exec \
    --bind $INDIR --bind . \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    busco \
        --cpu $SLURM_CPUS_PER_TASK \
        --mode genome --lineage brassicales_odb10 \
        --in $INDIR/assembly.fasta \
        --out ${ASSDIR}_busco_unpolished

singularity exec \
    --bind $INDIR --bind . \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    busco \
        --cpu $SLURM_CPUS_PER_TASK \
        --mode genome --lineage brassicales_odb10 \
        --in $INDIR/assembly.polished.fasta \
        --out ${ASSDIR}_busco_polished

mv ${ASSDIR}_busco_unpolished $OUTDIR/busco/unpolished
mv ${ASSDIR}_busco_polished $OUTDIR/busco/polished
