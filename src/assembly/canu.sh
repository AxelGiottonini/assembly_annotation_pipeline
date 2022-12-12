#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --job-name=assembly.canu
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Assembler/canu/2.1.1;

INDIR=./data/pacbio
OUTDIR=./out/assembly/canu

if ! [ -d ./out/ ]; then mkdir ./out/; fi
if ! [ -d ./out/assembly/ ]; then mkdir ./out/assembly/; fi
if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi

canu \
    -p canu -d $OUTDIR \
    genomeSize=130m \
    -pacbio $INDIR/* \
    gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
    gridOptions="--partition=pall --mail-user=axel.giottonini@students.unibe.ch"

module unload UHTS/Assembler/canu/2.1.1;

mv $OUTDIR/canu.contigs.fasta $OUTDIR/assembly.fasta
zip $OUTDIR/canu.other.zip  $OUTDIR/canu* $OUTDIR/correction $OUTDIR/trimming $OUTDIR/unitigging
rm -rf  $OUTDIR/unitigging $OUTDIR/trimming $OUTDIR/correction \
        $OUTDIR/canu.unassembled.fasta $OUTDIR/trimmedReads.fasta.gz \
        $OUTDIR/seqStore.sh $OUTDIR/canu.seqStore.err $OUTDIR/canu.seqStore \
        $OUTDIR/canu-scripts $OUTDIR/canu.report $OUTDIR/canu.out $OUTDIR/canu-logs \
        $OUTDIR/canu.correctedReads.fasta.gz $OUTDIR/canu.contigs.layout.tigInfo \
        $OUTDIR/canu.contigs.layout.readToTig