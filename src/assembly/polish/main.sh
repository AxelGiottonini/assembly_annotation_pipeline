#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=00:05:00
#SBATCH --job-name=assembly.polish.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

ASSDIR=$1

INDEX=$(sbatch ./src/assembly/polish/index.sh $ASSDIR)
ALIGN=$(sbatch --dependency=afterok:${INDEX##* } ./src/assembly/polish/align.sh $ASSDIR)
SAM2BAM=$(sbatch --dependency=afterok:${ALIGN##* } ./src/assembly/polish/sam2bam.sh $ASSDIR)
PILON=$(sbatch --dependency=afterok:${SAM2BAM##* } ./src/assembly/polish/pilon.sh $ASSDIR)
