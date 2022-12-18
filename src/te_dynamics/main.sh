#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

mkdir ./out/te_dynamics
mkdir ./out/te_dynamics/canu ./out/te_dynamics/flye ./out/te_dynamics/ref

UPDATE_CANU=$(sbatch ./src/te_dynamics/update_gff.sh canu)
UPDATE_FLYE=$(sbatch ./src/te_dynamics/update_gff.sh flye)

FASTA_CANU=$(sbatch --dependency=afterok:${UPDATE_CANU##* } ./src/te_dynamics/get_fasta.sh canu)
FASTA_FLYE=$(sbatch --dependency=afterok:${UPDATE_FLYE##* } ./src/te_dynamics/get_fasta.sh flye)

SORTER_CANU=$(sbatch --dependency=afterok:${FASTA_CANU##* } ./src/te_dynamics/te_sorter.sh canu)
SORTER_FLYE=$(sbatch --dependency=afterok:${FASTA_FLYE##* } ./src/te_dynamics/te_sorter.sh flye)
SORTER_REF=$(sbatch ./src/te_dynamics/te_sorter.sh ref)

PHYLO_REF=$(sbatch --dependency=afterok:${SORTER_REF##* } ./src/te_dynamics/phylogenetic/main.sh ref)
PHYLO_CANU=$(sbatch --dependency=afterok:${SORTER_CANU##* }:${PHYLO_REF##*} ./src/te_dynamics/phylogenetic/main.sh canu)
PHYLO_FLYE=$(sbatch --dependency=afterok:${SORTER_FLYE##* }:${PHYLO_REF##*} ./src/te_dynamics/phylogenetic/main.sh flye)

DATING_CANU=$(sbatch --dependency=afterok:${SORTER_CANU##* }:${PHYLO_REF##*} ./src/te_dynamics/dating/main.sh canu)
DATING_FLYE=$(sbatch --dependency=afterok:${SORTER_FLYE##* }:${PHYLO_REF##*} ./src/te_dynamics/dating/main.sh flye)
