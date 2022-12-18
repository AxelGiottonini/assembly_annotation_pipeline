# Genes Annotation Quality Check

## Busco
We check for BUSCOs using the `proteins` mode with `brassicales_odb10` lineage.

## Homologies
The proteins are extracted from the annotation using `seqkit` and divided as `known`
and `unknown`. Results are then then analyzed using the `BioPython` library.

## Quantification
The gene expression is evaluated using `Salmon` with indexes build with 21-mer or 31-mer
for comparison.

## Star
As liminary step, we convert the annotation `.gff` file to a `.gtf` file using `cufflinks`
`gffread` tool. The polished assembly is then indexed using the annotation `STAR`. `Illumina` reads are then mapped to the index using `STAR`. Finally the assembly and the 
alignement are indexed using `samtools`. The results can be displayed using `IGV`.