# Assembly

## Genome Assembly
The genome assembly pipeline handle two assemblers, `Canu` and `Flye`, used 
with the `PacBio` reads. Each assembler is run with an estimated genome size
of 130MB. `Illumina` reads are then aligned to the produced assembly using 
`Bowtie` and `samtools` for `.sam` to `.bam` conversion. The alignment is then
used with `Pilon` to polish the assembly.

## Transcriptome Assembly
We use `Trinity` for transcriptome assembly using `RNASeq` reads.
