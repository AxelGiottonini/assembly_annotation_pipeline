#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=2MB
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dynamics.phylogenetic.launcher
#SBATCH --mail-user=axel.giottonini@students.unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=pall

ASSDIR=$1

mkdir ./out/te_dynamics/$ASSDIR/phylogenetic
mkdir ./out/te_dynamics/$ASSDIR/phylogenetic/Ty1-RT ./out/te_dynamics/$ASSDIR/phylogenetic/Ty3-RT

if [[ "$ASSDIR" == "ref" ]]; then
    sed 's/\(.*\)#.*#.*Ty1-RT.*/\1_Ty1-RT/g' ./out/te_dynamics/$ASSDIR/*.fasta.rexdb-plant.cls.pep \
        | sed 's/\(.*\)#.*#.*Ty3-RT.*/\1_Ty3-RT/g' \
        > ./out/te_dynamics/$ASSDIR/phylogenetic/TE.pep

    sbatch ./src/te_dynamics/phylogenetic/extract_prot_seq.sh $ASSDIR
    exit 0
fi

sed 's/\(>TE_.*([-+.?])\)\(#.*\)\(\:Ty[13]-RT\)\(;.*\)/\1\3/g' ./out/te_dynamics/$ASSDIR/*.fasta.rexdb-plant.cls.pep \
    | sed 's/\(>tig.*([-+.?])\)\(#.*\)\(Ty[13]-RT\).*/\1_\3/g' \
    | sed 's/\(>contig.*([-+.?])\)\(#.*\)\(Ty[13]-RT\).*/\1_\3/g' \
    | sed 's/\(>scaffold.*([-+.?])\)\(#.*\)\(Ty[13]-RT\).*/\1_\3/g' \
    | sed 's/[:()]/_/g' \
    | sed 's/__/_/g' \
    > ./out/te_dynamics/$ASSDIR/phylogenetic/TE.pep

EXTRACT=$(sbatch ./src/te_dynamics/phylogenetic/extract_prot_seq.sh $ASSDIR)
ALIGN=$(sbatch --dependency=afterok:${EXTRACT##* } ./src/te_dynamics/phylogenetic/align.sh $ASSDIR)
TREE=$(sbatch --dependency=afterok:${ALIGN##* } ./src/te_dynamics/phylogenetic/ml_tree.sh $ASSDIR)