#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=512MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.phylogenetic.extract_prot_seq
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall
#SBATCH --array=0,1

module load UHTS/Analysis/SeqKit/0.13.2

ASSDIR=$1

RTs=('Ty1-RT' 'Ty3-RT')
RT=${RTs[$SLURM_ARRAY_TASK_ID]}

INDIR=./out/te_dynamics/$ASSDIR/phylogenetic
OUTDIR=./out/te_dynamics/$ASSDIR/phylogenetic/$RT

grep $RT $INDIR/TE.pep \
    | sed 's/>//' \
    > $OUTDIR/TE.lst

seqkit grep \
    -f $OUTDIR/TE.lst \
    $INDIR/TE.pep \
    -o $OUTDIR/TE.fasta

if [[ "$ASSDIR" == "ref" ]]; then
    exit 0
fi

cat ./out/te_dynamics/ref/phylogenetic/$RT/TE.fasta >> $OUTDIR/TE.fasta

module unload UHTS/Analysis/SeqKit/0.13.2