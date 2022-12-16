#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=genes_annotation_qc.busco
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Assembler/cufflinks/2.2.1;
module add UHTS/Aligner/STAR/2.7.9a
module load UHTS/Analysis/samtools/1.10;

ASSDIR=$1
INDIR=$( pwd )/out/genes_annotation/$ASSDIR
OUTDIR=$( pwd )/out/genes_annotation_qc/$ASSDIR/star
GENDIR=$( pwd )/out/assembly/$ASSDIR
READS=($( pwd )/data/RNAseq/*.fastq.gz)

# Convert GFF to GTF
#gffread -E $INDIR/annotated.all.gff -T -o $OUTDIR/annotated.all.gtf

# Generate genome index for star
#mkdir $OUTDIR/genome_index
#cd $OUTDIR/genome_index

#STAR \
#    --runThreadN $SLURM_CPUS_PER_TASK \
#    --runMode genomeGenerate \
#    --genomeDir $OUTDIR/genome_index \
#    --genomeFastaFiles $GENDIR/assembly.polished.fasta \
#    --sjdbGTFfile $OUTDIR/annotated.all.gtf

#cd - 

# Map RNASeq reads
#zcat ${READS[0]} > $OUTDIR/reads.1.fasta
#zcat ${READS[1]} > $OUTDIR/reads.2.fasta

##STAR \
#    --runThreadN $SLURM_CPUS_PER_TASK \
#    --genomeDir $OUTDIR/genome_index \
#    --readFilesIn $OUTDIR/reads.1.fasta $OUTDIR/reads.2.fasta \
#    --outFileNamePrefix $OUTDIR/ \
#    --outSAMtype BAM SortedByCoordinate \
#    --outFilterMultimapNmax 10 \
#    --outFilterMismatchNoverLmax 0.01 \
#    --alignIntronMax 60000

samtools index $OUTDIR/Aligned.sortedByCoord.out.bam -@ $SLURM_CPUS_PER_TASK
samtools faidx $GENDIR/assembly.polished.fasta

rm -rf $OUTDIR/reads.*.fasta $OUTDIR/Log.*
