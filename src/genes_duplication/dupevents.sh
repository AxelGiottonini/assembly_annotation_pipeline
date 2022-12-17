#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_duplication.dupevents
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load UHTS/Analysis/SeqKit/0.13.2
module add Emboss/EMBOSS/6.6.0
module load Phylogeny/paml/4.9j

ASSDIR=$1
PREFIX=$2
EVALUE=$3

OUTDIR=./out/genes_duplication/$ASSDIR/$EVALUE
SCRIPTS=/data/courses/assembly-annotation-course/CDS_annotation/scripts

sed 's/\(>.*-RA\).*/\1/g' ./out/genes_annotation/$ASSDIR/annotated.transcripts.fasta \
    > $OUTDIR/annotated.transcripts.simplified.fasta
cut -f 1 $OUTDIR/Ath.wgd.genes > $OUTDIR/Ath.wgd.genes.id

seqkit grep \
    -f $OUTDIR/Ath.wgd.genes.id \
    $OUTDIR/annotated.transcripts.simplified.fasta \
    -o $OUTDIR/Ath.wgd.genes.fasta

seqkit translate \
    $OUTDIR/Ath.wgd.genes.fasta \
    -o $OUTDIR/Ath.wgd.proteins.fasta
sed -i 's/_frame=1/_p/g' $OUTDIR/Ath.wgd.proteins.fasta 

cut -f 1,3 $OUTDIR/Ath.wgd.pairs \
    | sed 's/RA/RA_p/g' \
    > $OUTDIR/Ath.wgd.pairs.csv

mkdir $OUTDIR/events
mv $OUTDIR/Ath.wgd.pairs.csv $OUTDIR/events/Ath.wgd.pairs.csv
mv $OUTDIR/Ath.wgd.proteins.fasta $OUTDIR/events/Ath.wgd.proteins.fasta
mv $OUTDIR/Ath.wgd.genes.fasta $OUTDIR/events/Ath.wgd.genes.fasta

cd $OUTDIR/events
    $SCRIPTS/split_flat Ath.wgd.genes.fasta
    $SCRIPTS/split_flat Ath.wgd.proteins.fasta
    $SCRIPTS/bestflash_from_list Ath.wgd.pairs.csv
    $SCRIPTS/pair_to_CDS_paml_pair $PREFIX pair
    $SCRIPTS/PAML_yn00_from_CDS_pair $PREFIX > ../events.paml.out
cd - 
zip $OUTDIR/events.other.zip $OUTDIR/events
rm -rf $OUTDIR/events

awk '{print($1,$1,$6,$7,$5)}' $OUTDIR/events.paml.out \
    |sed 's/ /\t/g' \
    |sed 's/__x__/\t/' \
    |sed 's/_p//g' \
    |cut -f 1,2,4,5,6 \
    |sed 's/dN=//' \
    |sed 's/dS=//' \
    |sed 's/omega=//' \
    |awk '$4<5' \
    > $OUTDIR/Ath.wgd.kaks

cd $OUTDIR
    perl $SCRIPTS/add_ka_ks_to_collinearity_file.pl Ath
    perl $SCRIPTS/compute_ks_for_synteny_blocks.pl Ath.collinearity.kaks
    python $SCRIPTS/plot_syntenic_blocks_ks_distri.py Ath.synteny.blocks.ks.info 2 Ath
cd -


module unload UHTS/Analysis/SeqKit/0.13.2
module unload Phylogeny/paml/4.9j