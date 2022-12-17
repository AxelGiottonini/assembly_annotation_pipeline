#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.phylogenetic.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

ASSDIR=$1

mkdir ./out/te_dynamics/$ASSDIR/dating

sbatch ./src/te_dynamics/dating/dating.sh $ASSDIR C24_