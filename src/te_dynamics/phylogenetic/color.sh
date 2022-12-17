#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=512MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.phylogenetic.color
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall
#SBATCH --array=0,1

ASSDIR=$1

RTs=('Ty1-RT' 'Ty3-RT')
RT=${RTs[$SLURM_ARRAY_TASK_ID]}

INPDIR=./out/te_dynamics/$ASSDIR
OUTDIR=./out/te_dynamics/$ASSDIR/phylogenetic/$RT

PALETTE=("#3366FF" "#99CCFF" "#CC99FF" "#CCCCCC" "#6699CC" "#0099CC" "#33CCCC" \
  "#006699" "#003366" "#000066" "#333399" "#333333" "#666699" "#99CCCC" "#669999" "#006666" \
  "#003333" "#000033" "#333366" "#000000")

REF_CLADES=$( awk '! /#/ {print $4}' ./out/te_dynamics/ref/brassicaceae.fasta.rexdb-plant.cls.tsv | sort | uniq )
CUR_CLADES=$( awk '! /#/ {print $4}' ./out/te_dynamics/canu/TE.fasta.rexdb-plant.cls.tsv | sort | uniq )
CLADES=($(printf "%s\n" "${REF_CLADES[@]}" "${CUR_CLADES[@]}" | sort | uniq))

sed -i -e "s/$RT//g" $OUTDIR/*.tree
cp ./src/te_dynamics/phylogenetic/color_template.txt $OUTDIR/colors.txt
for i in "${!CLADES[@]}"; do
    grep -e ${CLADES[$i]} $INPDIR/TE.fasta.rexdb-plant.cls.tsv \
        | cut -f 1 \
        | sed 's/[:()]/_/g' \
        | sed 's/__/_/g' \
        | sed -e "s/$/ ${PALETTE[$i]}/g" \
        | grep '#' >> $OUTDIR/colors.txt

    grep -e ${CLADES[$i]} ./out/te_dynamics/ref/brassicaceae.fasta.rexdb-plant.cls.tsv \
        | cut -f 1 \
        | sed 's/[:()]/_/g' \
        | sed 's/__/_/g' \
        | sed -e "s/$/ ${PALETTE[$i]}/g" \
        | grep '#' >> $OUTDIR/colors.txt
done
