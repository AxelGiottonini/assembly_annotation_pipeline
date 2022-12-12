#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=assembly_qc.merqury
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Analysis/pilon/1.22;

ASSDIR=$1
INDIR=./out/assembly/$ASSDIR
OUTDIR=./out/assembly_qc/$ASSDIR/
MERDIR=./out/assembly_qc/meryl

mkdir $OUTDIR/merqury
mkdir $OUTDIR/merqury/polished
mkdir $OUTDIR/merqury/unpolished

singularity exec \
	--bind $INDIR --bind $OUTDIR/merqury --bind $OUTDIR/merqury/unpolished \
	/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
	merqury.sh \
		$MERDIR/db.meryl \
		$INDIR/assembly.fasta \
		$OUTDIR/merqury/unpolished

singularity exec \
	--bind $INDIR --bind $OUTDIR/merqury --bind $OUTDIR/merqury/polished\
	/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
	merqury.sh \
		$MERDIR/db.meryl \
		$INDIR/assembly.polished.fasta \
		$OUTDIR/merqury/polished