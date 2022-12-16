#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_annotation_qc.salmon
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

salmon=$( pwd )/salmon/bin/salmon

ASSDIR=$1
K=$2
INDIR=$( pwd )/out/genes_annotation/$ASSDIR
OUTDIR=$( pwd )/out/genes_annotation_qc/$ASSDIR/salmon/$K
READS=($( pwd )/data/RNAseq/*.fastq.gz)

mkdir $OUTDIRq

$salmon index -t $INDIR/annotated.transcripts.fasta -i $OUTDIR/annotated.transcripts.index -k $K
$salmon quant -i $OUTDIR/annotated.transcripts.index -l A -1 ${READS[0]} -2 ${READS[1]} --validateMappings -o $OUTDIR/annotated.transcripts.quant