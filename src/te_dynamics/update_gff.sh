#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=64MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.update_gff
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

ASSDIR=$1
INDIR=$( pwd )/out/te_annotation/$ASSDIR/automated
OUTDIR=$( pwd )/out/te_dynamics/$ASSDIR

awk '$3~/retrotransposon/' $INDIR/assembly.polished.fasta.mod.EDTA.TEanno.gff3 > $OUTDIR/TEanno.gff3 
grep -v LTR $INDIR/assembly.polished.fasta.mod.EDTA.TEanno.gff3 >> $OUTDIR/TEanno.gff3

sed 's/ID=.*;Name=//g' $OUTDIR/TEanno.gff3 \
    | sed 's/;Classification=.*//g' \
    | awk '{printf ("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n", $1, $2, $9, $4, $5, $6, $7, $8, $3)}' \
    | awk '{gsub(/[\.:]+/, "_", $3)} 1' \
    | sed 's/\s/\t/g' \
    > $OUTDIR/TEanno.renamed.gff3

mv $OUTDIR/TEanno.renamed.gff3 $OUTDIR/TEanno.gff3