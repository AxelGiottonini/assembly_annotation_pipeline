#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64GB
#SBATCH --time=03-00:00:00
#SBATCH --job-name=genes_annotation.maker
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

module load SequenceAnalysis/GenePrediction/maker/2.31.9;

ASSDIR=$1
GENOME=$( echo "$( pwd )/out/assembly/${ASSDIR}/assembly.polished.fasta" | sed -e 's/[]\/$*.^[]/\\&/g')
TRANSCRIPTOME=$( echo "$( pwd )/out/assembly/trinity/assembly.fasta" | sed -e 's/[]\/$*.^[]/\\&/g' )
PROTEINS=$( echo "/data/courses/assembly-annotation-course/CDS_annotation/Atal_v10_CDS_proteins, /data/courses/assembly-annotation-course/CDS_annotation/uniprot-plant_reviewed.fasta" | sed -e 's/[]\/$*.^[]/\\&/g' )
TELib=$( echo "$( pwd )/out/te_annotation/${ASSDIR}/automated/assembly.polished.fasta.mod.EDTA.TElib.fa" | sed -e 's/[]\/$*.^[]/\\&/g' )
REPProteins=$( echo "/data/courses/assembly-annotation-course/CDS_annotation/PTREP20" | sed -e 's/[]\/$*.^[]/\\&/g' )

cd ./out/genes_annotation/$ASSDIR

maker -CTL

sed -i "s/^genome=.*/genome=${GENOME}/g" maker_opts.ctl
sed -i "s/^est=.*/est=${TRANSCRIPTOME}/g" maker_opts.ctl
sed -i "s/^protein=.*/protein=$PROTEINS/g" maker_opts.ctl
sed -i "s/^rmlib=.*/rmlib=${TELib}/g" maker_opts.ctl
sed -i "s/^repeat_protein=.*/repeat_protein=${REPProteins}/g" maker_opts.ctl
sed -i "s/^st2genome=.*/st2genome=1/g" maker_opts.ctl
sed -i "s/^protein2genome=.*/protein2genome=1/g" maker_opts.ctl
sed -i "s/^cpus=.*/cpus=${SLURM_CPUS_PER_TASK}/g" maker_opts.ctl
sed -i "s/^TMP=.*/TMP=\$SCRATCH/g" maker_opts.ctl

maker

cd -