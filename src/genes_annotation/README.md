# Genes Annotation

Gene annotation is built on three process. First, we use `Maker` to annotate the
assembly using a genome assembly, the transcriptome assembly, annotated protein
from the reference genome of Arabidopsis t. and the `uniprot` plant database,
the transposable elements library produced with the `te_annotation` pipeline and
the repeat proteins from the reference genome. Then we annotate the proteins 
putative function using `Blast` against the `uniprot` database. The results are 
then merged using `maker` dedicated functions.