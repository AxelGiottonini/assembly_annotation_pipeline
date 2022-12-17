#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=512MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.phylogenetic.extract_prot_seq
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load UHTS/Analysis/BEDTools/2.29.2
module add Emboss/EMBOSS/6.6.0;

ASSDIR=$1
PREFIX=$2

INPDIR=$( pwd )/out/te_annotation/$ASSDIR/automated
OUTDIR=$( pwd )/out/te_dynamics/$ASSDIR/dating
SCRIPTS=/data/courses/assembly-annotation-course/CDS_annotation/scripts

awk '$3 ~ /retrotransposon/' $INPDIR/assembly.polished.fasta.mod.EDTA.intact.gff3 \
    | sed 's/ID.\+Name=//' \
    | sed 's/;.\+//' \
    | awk '{print($1,$2,$9,$4,$5,$6,$7,$8,$3)}' \
    | sed 's/ /\t/g' \
    > $OUTDIR/assembly.polished.fasta.mod.EDTA.intact.LTR.gff

bedtools getfasta \
    -fi $( pwd )/out/assembly/$ASSDIR/assembly.polished.fasta \
    -bed $OUTDIR/assembly.polished.fasta.mod.EDTA.intact.LTR.gff \
    -name \
    > $OUTDIR/assembly.polished.fasta.mod.EDTA.intact.LTR.fasta 

sed -i 's/:/_/g' $OUTDIR/assembly.polished.fasta.mod.EDTA.intact.LTR.fasta
sed -i -e "s/>/>$PREFIX/g" $OUTDIR/assembly.polished.fasta.mod.EDTA.intact.LTR.fasta

cd $OUTDIR
$SCRIPTS/split_flat $OUTDIR/assembly.polished.fasta.mod.EDTA.intact.LTR.fasta
$SCRIPTS/LTR $PREFIX N 

$SCRIPTS/date_pair
cd -

rm -rf $OUTDIR/$PREFIX*