#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=assembly_qc.merqury
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Analysis/pilon/1.22;

ASSDIR=$1
INDIR=$( pwd )/out/assembly/$ASSDIR
OUTDIR=$( pwd )/out/assembly_qc/$ASSDIR
MERDIR=$( pwd )/out/assembly_qc/meryl/db.meryl

mkdir $OUTDIR/merqury

## Unpolished
mkdir $OUTDIR/merqury/unpolished $OUTDIR/merqury/unpolished/db.meryl
cd $OUTDIR/merqury/unpolished

cp $MERDIR/* db.meryl/
cp $INDIR/assembly.fasta assembly.fasta

singularity exec \
	--bind . \
	/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
	merqury.sh \
		db.meryl \
		assembly.fasta \
		out

rm -rf db.meryl assembly.fasta
cd - 

## Polished
mkdir $OUTDIR/merqury/polished $OUTDIR/merqury/polished/db.meryl
cd $OUTDIR/merqury/polished

cp $MERDIR/* db.meryl/
cp $INDIR/assembly.polished.fasta assembly.fasta

singularity exec \
	--bind . \
	/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
	merqury.sh \
		db.meryl \
		assembly.fasta \
		out

rm -rf db.meryl assembly.fasta
cd - 