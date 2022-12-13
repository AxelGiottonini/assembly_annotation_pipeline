#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=00:05:00
#SBATCH --job-name=assembly.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

sbatch ./src/assembly/canu.sh
sbatch ./src/assembly/flye.sh
sbatch ./src/assembly/trinity.sh