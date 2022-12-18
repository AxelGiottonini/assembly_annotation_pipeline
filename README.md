# Genome and Transcriptome Assembly & Genome Annotation

Welcome to our genome and transcriptome assembly project! In this project, we 
will be using computational tools and techniques to assemble and analyze DNA 
sequences from a variety of sources. We will explore the principles and 
challenges of DNA sequence assembly and the various methods used to overcome 
these challenges

## Introduction
Arabidopsis thaliana is a small flowering plant that is widely used as a model 
organism in plant biology research. It is native to Europe, Asia, and North 
Africa. Arabidopsis haliana has a small genome (about 157 million base pairs) and a 
short life cycle, making it a valuable model for studying plant development and 
genetics. Researchers have identified and characterized many of the genes in the 
Arabidopsis genome, and the plant has been used in numerous genetic and genomic 
studies, helping to advance our understanding of plant biology.

### Genome Assembly
Paired de Bruijn graphs (`Flye`) and overlap graphs (`Canu`) are two tools commonly used in genome 
assembly to reconstruct a genome from its sequencing reads. Paired de Bruijn graphs 
use paired end reads, which are sequences taken from both ends of a fragment of DNA, 
to improve the accuracy of genome reconstruction. They do this by creating a graph 
structure where the nodes represent k-mers (short DNA sequences of length k) and the 
edges represent the overlap between these k-mers. Overlap graphs, on the other hand, 
use the overlaps between reads to build a scaffold of the genome, which can then be 
used to guide the assembly process. Both paired de Bruijn graphs and overlap graphs 
can help to improve the quality and accuracy of genome assembly by providing 
additional information about the genome structure and sequence.

### Transposable Elements
Transposable elements, also known as transposons, are pieces of DNA that can move 
around within a genome. They are found in the genomes of almost all organisms. 
Transposable elements can insert themselves into different locations within a genome, 
and they can also be copied and transmitted to offspring.
![Transposable Elements](https://d3i71xaburhd42.cloudfront.net/2dd1e797975cee69fa81d099b1671a5ce3b331e5/11-Figure4-1.png)

### Genome Duplication Event
Genome duplication, also known as genome duplication or whole genome duplication, 
is a process by which an organism's genome is duplicated in its entirety, resulting 
in two copies of the genome. This can occur through a variety of mechanisms, including 
mitotic crossing-over and endoreplication. Genome duplication can have significant 
impacts on the evolution and adaptation of organisms, as it can lead to the creation of 
new gene copies that can acquire new functions or be lost through the process of gene 
loss. Synteny refers to the conservation of gene order between different genomes or 
genome segments. Syntenic regions are thought to have evolved under selective pressure 
to maintain their function, and synteny can be used to study the evolution and function 
of genes.

## Pipeline
Here is briefly presented the pipeline. If you want further details, a readme
file is present at each main process of the pipeline:
- **assembly:** Genomes assembly were produced using pacbio reads with two
different assembler: `Flye` and `Canu`. A transcriptome assembly was build 
with the Illumina-RNAseq reads using `Trinity`.
- assembly_qc
- genes_annotation
- genes_annotation_qc
- genes_duplication
- **reads_qc:** 
- te_annotation
- te_dynamics

## Results
Although some tools from the pipeline provide results to be reported, we also
wanted to have some meaningfull comparisons between the different tools. That's
why we implemented 5 `Jupyter Notebooks` to analyse the outputs.

The `assembly_qc.ipynb` notebook provides illustration to compare BUSCO's and 
Quast's results between the different assembler. It shows first that the assembly
polishing, using `Salmon` was successfull as it improves the completeness of
the assemblies. It also shows that most of the missing sequences are shared
between the assemblies and we can thus hypothesize that these sequences may have
not been sequenced.

The `assembly_comparison.ipynb` notebook plots the alignment of the genome 
assemblies against Arabidopsis t. reference genome. It shows that both
assemblies are very similar, highlighting what was said about completeness
in the previous notebook. It also shows the ability of `Flye` to merge
smaller contigs into a bigger contig what may explain why the `BUSCO` results 
of `Flye` are slightly better than those of `Canu`.

The `te_dynamics.ipynb` notebook provides the tree visualisation of the 
retrotranscriptase for different TE (Gypsy and Copia). It also displays a plot
presenting the dating of the TEs.

The `genes_annotation_qc.ipynb` notebook provides the analysis for the different
quality check we ran on the annotated genome. It present the comparison between
the BUSCO's annotation for each assembly, the homologies quantification as well
as the distribution of the length of the known and unknown annotated proteins.
The results obtained with `Salmon` are compared between each assembler and two
$k$-mers length. Finally an implementation of the `IGV` viewer is present.

The `genes_duplication.ipynb` notebook simply provides a viewer for the different
results obtained from DupGen.