# Assembly Comparison

The assembly comparison pipeline requires to align the assemblies against a 
reference genome using `nucmer` with `--breaklen 1000` and 
`--mincluster 10000` options. The plot is then built using `mummerplot` with
the `--fat` option to enforce continuity in between contigs.
    