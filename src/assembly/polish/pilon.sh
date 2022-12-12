#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --job-name=assembly.polish.pilon
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Analysis/pilon/1.22;

ASSDIR=$1
INDIR=./out/assembly/$ASSDIR
OUTDIR=./out/assembly/$ASSDIR/polish

java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
    --genome $INDIR/assembly.fasta \
    --bam $OUTDIR/alignment.bam \
    --threads $SLURM_CPUS_PER_TASK \
    --outdir $OUTDIR

mv $OUTDIR/pilon.fasta $INDIR/assembly.polished.fasta

module unload UHTS/Analysis/pilon/1.22;