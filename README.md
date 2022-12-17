# Genome and Transcriptome Assembly & Genome Annotation

Welcome to our genome and transcriptome assembly project! In this project, we 
will be using computational tools and techniques to assemble and analyze DNA 
sequences from a variety of sources. We will explore the principles and 
challenges of DNA sequence assembly and the various methods used to overcome 
these challenges

## Introduction on Arabidopsis thaliana
Arabidopsis thaliana is a small flowering plant that is widely used as a model 
organism in plant biology research. It is native to Europe, Asia, and North 
Africa. Arabidopsis haliana has a small genome (about 157 million base pairs) and a 
short life cycle, making it a valuable model for studying plant development and 
genetics. Researchers have identified and characterized many of the genes in the 
Arabidopsis genome, and the plant has been used in numerous genetic and genomic 
studies, helping to advance our understanding of plant biology.

### Transposable Elements
Transposable elements, also known as transposons, are pieces of DNA that can move 
around within a genome. They are found in the genomes of almost all organisms. 
Transposable elements can insert themselves into different locations within a genome, 
and they can also be copied and transmitted to offspring.

Gypsy (GAG-PROT-**INT-RT-RH**) and Copia (GAG-PROT-**RT-RH-INT**) are transposable 
elements that move around within genomes and can alter gene expression. They can 
contribute to genetic diversity but also have negative effects. Found in many 
organisms, including plants, animals, and fungi.


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
why we implemented 4 `Jupyter Notebooks` to analyse the outputs.

The `assembly_qc.ipynb` notebook provides illustration to compare BUSCO's and 
Quast's results between the different assembler. It shows first that the assembly
polishing, using `Salmon` was successfull as it improves the completeness of
the assemblies. It also shows that most of the missing sequences are shared
between the assemblies and we can thus hypothesize that these sequences may have
not been sequenced.

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