#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.phylogenetic.align
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall
#SBATCH --array=0,1

module load SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4

ASSDIR=$1

RTs=('Ty1-RT' 'Ty3-RT')
RT=${RTs[$SLURM_ARRAY_TASK_ID]}

OUTDIR=./out/te_dynamics/$ASSDIR/phylogenetic/$RT

clustalo -i $OUTDIR/TE.fasta -o $OUTDIR/alignment.fasta

module unload SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4