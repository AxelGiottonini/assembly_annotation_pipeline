# Assembly

The assembly pipeline handle three assemblers: `Canu` and `Flye` for the genome
assembly using `PacBio` reads and `Trinity` for the transcriptome assembly
using `RNASeq` reads. Both genome assemblers are run with an estimated genome
size of 130MB. Genome assemblies are then polished using `Pilon` which requires
to align `Illumina` reads to the assembly (`Bowtie` and `samtools`).
