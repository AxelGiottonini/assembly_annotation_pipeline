#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=40GB
#SBATCH --time=01:00:00
#SBATCH --job-name=reads_qc.kmer_stats
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

SEQDIR=$1
INDIR=./data/$SEQDIR
OUTDIR=./out/reads_qc/kmer_stats/$SEQDIR

if ! [ -d ./out/ ]; then mkdir ./out/; fi
if ! [ -d ./out/reads_qc/ ]; then mkdir ./out/reads_qc/; fi
if ! [ -d ./out/reads_qc/kmer_stats/ ]; then mkdir ./out/reads_qc/kmer_stats/; fi
if ! [ -d $OUTDIR ]; then mkdir $OUTDIR; fi

module load UHTS/Analysis/jellyfish/2.3.0

for reads in $INDIR/*.fastq.gz; do
    # Parse filename
    filename="${reads[*]: ${#INDIR}+1}"
    filename="${filename%.*.*}"

    # Count k-mers (k=21)
    jellyfish count \
        -C -m 21 -s 5G -t $SLURM_CPUS_PER_TASK \
        -o $OUTDIR/$filename.cnts <(zcat $reads)

    # Histogram & stats
    jellyfish histo \
        -f $OUTDIR/$filename.cnts > $OUTDIR/$filename.histo
    jellyfish stats \
        -f $OUTDIR/$filename.cnts > $OUTDIR/$filename.stats
done

module unload UHTS/Analysis/jellyfish/2.3.0