# TE Dynamics

In liminary steps, the annotation files are filtered to display only retrotransposons and preprocessed to fit `TESorter` requirements. The sequences are then obtained using `Bedtools`. `TESorter` is then run using the sequences file and the `rexdb-plant` database.

**Note** `TESorter` is also run with Brassicaceae reference annotation.

## Phylogenetic
We extract sequences of interest using `seqkit` and concatenate them to the *Brassicaceae* TEs list. The sequences are then aligned using `clustal omega`. Finally we use `FastTree` to build the tree. Trees can be visualized using [iTol](https://itol.embl.de/). The dataset annotation file for coloring is build using the `color.sh` script.

## Dating
We extract sequences of interest using `bedtools` and use the scripts provided for the course to compute the dating.