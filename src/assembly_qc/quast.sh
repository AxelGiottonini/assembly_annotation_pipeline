#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=assembly_qc.quast
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module add UHTS/Quality_control/quast/4.6.0;

ASSDIR=$1
INDIR=./out/assembly/$ASSDIR
OUTDIR=./out/assembly_qc/$ASSDIR

REFERENCE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

if ! [ -d ./out/ ]; then mkdir ./out/; fi
if ! [ -d ./out/assembly_qc/ ]; then mkdir ./out/assembly_qc/; fi
if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi
if ! [ -d $OUTDIR/quast ]; then mkdir $OUTDIR/quast; fi

quast.py \
    -o $OUTDIR/quast/polished \
    -R $REFERENCE \
    -t $SLURM_CPUS_PER_TASK \
    -e \
    $INDIR/assembly.polished.fasta

quast.py \
    -o $OUTDIR/quast/unpolished \
    -R $REFERENCE \
    -t $SLURM_CPUS_PER_TASK \
    -e \
    $INDIR/assembly.fasta
