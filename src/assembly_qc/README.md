# Assembly Quality Check

## BUSCO
We check for BUSCOs using the `genome` mode with `brassicales_odb10` lineage
for polished and unpolished assemblies.

## Quast
We check for completeness of the assemblies using `Quast` using 
**Arabidopsis t. TAIR10** as reference for polished and unpolished assemblies.

## Merqury
We build a `meryl` database using the `Illumina` reads using 21-mers. The
database is then used to run `Merqury` on polished and unpolished assemblies.