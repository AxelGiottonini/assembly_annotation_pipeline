# Genome and Transcriptome Assembly & Genome Annotation

## Workflow
1. Run quality check & statistics on reads:
```
sbatch ./src/reads_qc/main.sh
```

2. Run assemblers:
```
sbatch ./src/assembly/main.sh
```

3. Run assembly polising:
```
sbatch ./src/assembly/polish/main.sh <canu/flye>
```

4. Run assembly quality check:
```
sbatch ./src/assembly_qc/main.sh
```

## Dataset
```
data/
|---Illumina/
    |---reads_1.fastq.gz
    |---reads_2.fastq.gz
|---pacbio/
    |---reads_1.fastq.gz
    |---reads_2.fastq.gz
|---rnaseq/
    |---reads_1.fastq.gz
    |---reads_2.fastq.gz
```

## Scripts
```
src/
|---assembly/
    |---canu.sh
    |---flye.sh
    |---main.sh
    |---polish/
        |---align.sh
        |---index.sh
        |---main.sh
        |---pilon.sh
        |---sam2bam.sh
|---assembly_qc/
    |---busco.sh
    |---main.sh
    |---merqury.sh
    |---meryl.sh
    |---quast.sh
|---reads_qc/
    |---kmer_stats.sh
    |---main.sh
    |---qc.sh
```