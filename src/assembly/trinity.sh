#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --job-name=assembly.trinity
#SBATCH --mail-type=end
#SBATCH --partition=pall

module load UHTS/Assembler/trinityrnaseq/2.5.1;

INDIR=./data/RNAseq
OUTDIR=./out/assembly/trinity

READS=($INDIR/*.fastq.gz)

Trinity \
    --seqType fq \
    --left ${READS[0]} \
    --right ${READS[1]} \
    --CPU $SLURM_CPUS_PER_TASK --max_memory 64G \
    --output $OUTDIR

zip $OUTDIR/trinity.other.zip $OUTDIR/both.fa $OUTDIR/inchworm.K25.L25.DS.fa $OUTDIR/jellyfish.kmers.fa $OUTDIR/partitioned_reads.files.list.ok $OUTDIR/recursive_trinity.cmds.completed \
    $OUTDIR/both.fa.ok $OUTDIR/inchworm.K25.L25.DS.fa.finished $OUTDIR/jellyfish.kmers.fa.histo $OUTDIR/pipeliner.50962.cmds $OUTDIR/recursive_trinity.cmds.ok $OUTDIR/Trinity.fasta.gene_trans_map \
    $OUTDIR/both.fa.read_count $OUTDIR/inchworm.kmer_count $OUTDIR/left.fa.ok $OUTDIR/read_partitions $OUTDIR/right.fa.ok $OUTDIR/Trinity.timing \
    $OUTDIR/chrysalis $OUTDIR/insilico_read_normalization $OUTDIR/partitioned_reads.files.list $OUTDIR/recursive_trinity.cmds $OUTDIR/scaffolding_entries.sam \
    $OUTDIR/.iworm.ok $OUTDIR/.jellyfish_count.ok  $OUTDIR/.jellyfish_histo.ok $OUTDIR/.iworm_renamed.ok $OUTDIR/.jellyfish_dump.ok

rm -rf $OUTDIR/both.fa $OUTDIR/inchworm.K25.L25.DS.fa $OUTDIR/jellyfish.kmers.fa $OUTDIR/partitioned_reads.files.list.ok $OUTDIR/recursive_trinity.cmds.completed \
    $OUTDIR/both.fa.ok $OUTDIR/inchworm.K25.L25.DS.fa.finished $OUTDIR/jellyfish.kmers.fa.histo $OUTDIR/pipeliner.50962.cmds $OUTDIR/recursive_trinity.cmds.ok $OUTDIR/Trinity.fasta.gene_trans_map \
    $OUTDIR/both.fa.read_count $OUTDIR/inchworm.kmer_count $OUTDIR/left.fa.ok $OUTDIR/read_partitions $OUTDIR/right.fa.ok $OUTDIR/Trinity.timing \
    $OUTDIR/chrysalis $OUTDIR/insilico_read_normalization $OUTDIR/partitioned_reads.files.list $OUTDIR/recursive_trinity.cmds $OUTDIR/scaffolding_entries.sam \
    $OUTDIR/.iworm.ok $OUTDIR/.jellyfish_count.ok  $OUTDIR/.jellyfish_histo.ok $OUTDIR/.iworm_renamed.ok $OUTDIR/.jellyfish_dump.ok

mv $OUTDIR/Trinity.fasta $OUTDIR/assembly.fasta