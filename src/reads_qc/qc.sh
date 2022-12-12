#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00
#SBATCH --job-name=reads_qc.qc
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load UHTS/Quality_control/fastqc/0.11.9

SEQDIR=$1
INDIR=./data/$SEQDIR
OUTDIR=./out/reads_qc/qc/$SEQDIR

if ! [ -d ./out/ ]; then mkdir ./out/; fi
if ! [ -d ./out/reads_qc/ ]; then mkdir ./out/reads_qc/; fi
if ! [ -d ./out/reads_qc/qc/ ]; then mkdir ./out/reads_qc/qc/; fi
if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi

fastqc -o $OUTDIR -f fastq $INDIR/*.fastq.gz
rm -rf $OUTDIR/*.zip

module unload UHTS/Quality_control/fastqc/0.11.9
