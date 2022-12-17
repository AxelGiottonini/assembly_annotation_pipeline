#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --job-name=genes_duplication.dupgen
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load Blast/ncbi-blast/2.10.1+;

ASSDIR=$1
EVALUE=$2
OUTDIR=./out/genes_duplication/$ASSDIR/$EVALUE

TARGET_GFF=$( pwd )/out/genes_annotation/$ASSDIR/annotated.all.gff
OUTGROUP_GFF=/data/courses/assembly-annotation-course/CDS_annotation/NNU_mRNA_single_model.gff
TARGET_FASTA=$( pwd )/out/genes_annotation/$ASSDIR/annotated.proteins.fasta
OUTGROUP_FASTA=/data/courses/assembly-annotation-course/CDS_annotation/NNU.pep.fa.ref.single_model

# gene position file for the target species
#   Remark: mRNA and genes position in GFF files are equals. To avoid
#   processing files, we use the mRNA entry which name correspond to the 
#   id of the proteins.
awk '$3 ~ /mRNA/ && $9 ~ /.*-RA.*/' $TARGET_GFF \
    | sed 's/ID=.*;Name=//g' \
    | sed 's/;.*//g' \
    | awk '{printf ("%s\t%s\t%s\t%s\n", $1, $9, $4, $5)}' \
    | awk '{gsub(/[\.:]+/, "_", $3)} 1' \
    | sed 's/\s/\t/g' \
    > $OUTDIR/Ath.gff

# build blast db from target proteins
makeblastdb -in $TARGET_FASTA -dbtype prot -title Ath -out $OUTDIR/blast_db

# blastp output file (-outfmt 6) for the target species
blastp \
    -query $TARGET_FASTA \
    -db $OUTDIR/blast_db \
    -evalue $EVALUE \
    -max_target_seqs 5 \
    -outfmt 6 \
    -num_threads $SLURM_CPUS_PER_TASK \
    -out $OUTDIR/Ath.blast

# gene position file for the target_species and outgroup_species
cat $OUTDIR/Ath.gff $OUTGROUP_GFF > $OUTDIR/Ath_Nnu.gff

# blastp output file (-outfmt 6) between the target and outgroup species
blastp \
    -query $OUTGROUP_FASTA \
    -db $OUTDIR/blast_db \
    -evalue $EVALUE \
    -max_target_seqs 5 \
    -outfmt 6 \
    -num_threads $SLURM_CPUS_PER_TASK \
    -out $OUTDIR/Ath_Nnu.blast

rm -rf $OUTDIR/blast_db.*

# run dupgen
DupGen_finder.pl -i $OUTDIR -t Ath -c Nnu -o $OUTDIR

cd $OUTDIR
zip dupgen.other.zip Ath.gff Ath_Nnu.gff Ath.blast Ath_Nnu.blast Ath.dispersed.* Ath.proximal.* Ath.tandem.* Ath.transposed.* \
    annotated.transcripts.simplified.fasta Ath_Nnu.collinearity Ath.wgd.genes.id Ath.gff.sorted Ath.wgd.genes Ath.singletons \
    Ath.wgd.pairs 
rm Ath.gff Ath_Nnu.gff Ath.blast Ath_Nnu.blast Ath.dispersed.* Ath.proximal.* Ath.tandem.* Ath.transposed.* \
    annotated.transcripts.simplified.fasta Ath_Nnu.collinearity Ath.wgd.genes.id Ath.gff.sorted Ath.wgd.genes Ath.singletons \
    Ath.wgd.pairs
cd -