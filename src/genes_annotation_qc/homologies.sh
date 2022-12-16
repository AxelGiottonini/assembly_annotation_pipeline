#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_annotation_qc.homologies
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load UHTS/Analysis/SeqKit/0.13.2

ASSDIR=$1
INDIR=$( pwd )/out/genes_annotation/$ASSDIR
OUTDIR=$( pwd )/out/genes_annotation_qc/$ASSDIR/homologies

# Get the list of proteins
sed 's/\(>\S*\).*/\1/g' $INDIR/annotated.proteins.fasta > $OUTDIR/proteins.fasta
grep ">" $INDIR/annotated.proteins.fasta | sed 's/\(>\S*\).*/\1/g' > $OUTDIR/proteins.txt
grep ">" $INDIR/annotated.proteins.fasta | grep "Protein of unknown function" | sed 's/\(>\S*\).*/\1/g' > $OUTDIR/proteins.known.txt
grep ">" $INDIR/annotated.proteins.fasta | grep -v "Protein of unknown function" | sed 's/\(>\S*\).*/\1/g' > $OUTDIR/proteins.unknown.txt

seqkit grep \
    -f $OUTDIR/proteins.known.txt \
    $OUTDIR/proteins.fasta \
    -o $OUTDIR/proteins.known.fasta
    
seqkit grep \
    -f $OUTDIR/proteins.unknown.txt \
    $OUTDIR/proteins.fasta \
    -o $OUTDIR/proteins.unknown.fasta

module unload UHTS/Analysis/SeqKit/0.13.2