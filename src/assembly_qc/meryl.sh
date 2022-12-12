#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=assembly_qc.meryl
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall

INPDIR=./data/Illumina
OUTDIR=./out/assembly_qc/meryl

if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi

cp $INPDIR/*.fastq.gz $OUTDIR/
gunzip $OUTDIR/*.fastq.gz
READS=($OUTDIR/*.fastq)

singularity exec \
	--bind $OUTDIR \
	/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
	meryl \
        union-sum \
        output $OUTDIR/db.meryl \
        [count k=21 ${READS[0]} output $OUTDIR/reads1.meryl] \
        [count k=21 ${READS[1]} output $OUTDIR/reads2.meryl] \

rm -rf $OUTDIR/*.fastq