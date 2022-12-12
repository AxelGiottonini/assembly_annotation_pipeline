#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --job-name=assembly.polish.sam2bam
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Analysis/samtools/1.10;

ASSDIR=$1
INDIR=./out/assembly/$ASSDIR/polish
OUTDIR=./out/assembly/$ASSDIR/polish
TMPDIR=./out/assembly/$ASSDIR/polish/temp

mkdir $TMPDIR

samtools sort \
    -T $TMPDIR \
    -@ $SLURM_CPUS_PER_TASK \
    $OUTDIR/alignment.sam \
    -o $OUTDIR/alignment.sorted.sam
samtools view -bS $OUTDIR/alignment.sorted.sam > $OUTDIR/alignment.bam
samtools index $OUTDIR/alignment.bam


rm -rf $OUTDIR/alignment.sam $OUTDIR/alignment.sorted.sam $OUTDIR/index.1.bt2 $OUTDIR/index.2.bt2 $OUTDIR/index.3.bt2 $OUTDIR/index.4.bt2 $OUTDIR/index.rev.1.bt2 $OUTDIR/index.rev.2.bt2
rm -rf $TMPDIR

module unload UHTS/Analysis/samtools/1.10;
