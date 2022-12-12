#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --time=12:00:00
#SBATCH --mem=128G
#SBATCH --job-name=assembly.flye
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Assembler/flye/2.8.3;

INDIR=./data/pacbio
OUTDIR=./out/assembly/flye

if ! [ -d ./out/ ]; then mkdir ./out/; fi
if ! [ -d ./out/assembly/ ]; then mkdir ./out/assembly/; fi
if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi

flye \
	--pacbio-raw $INDIR/* \
	--genome-size 130m \
	--threads $SLURM_CPUS_PER_TASK \
	--out-dir $OUTDIR

module unload UHTS/Assembler/flye/2.8.3;

zip $OUTDIR/flye.others.zip $OUTDIR/00-* $OUTDIR/10-* $OUTDIR/20-* $OUTDIR/30-* $OUTDIR/40-* $OUTDIR/assembly_* $OUTDIR/flye.log $OUTDIR/params.json
rm -rf $OUTDIR/00-* $OUTDIR/10-* $OUTDIR/20-* $OUTDIR/30-* $OUTDIR/40-* $OUTDIR/assembly_* $OUTDIR/flye.log $OUTDIR/params.json
