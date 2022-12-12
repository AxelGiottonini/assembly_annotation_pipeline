# Assembly
- Use `canu.sh` to perform the Canu assembly with the pacbio reads.
- Use `flye.sh` to perform the Flye assembly with the pacbio reads.

Once the file have been assembled, run `./src/assembly/polish/main.sh <canu/flye>` to polish each assembly. The script will launch sequencially each of the subprocess required for polishing.

## Special attention using `SLURM`
In the case you are using `SLURM` as queue manager, you may have some of `Canu` jobs pending with the status ReqNotNotAvail. This is due to the fact that `Canu` will specify a time limit equal to the maximum time limit on the partition you are using. You can simply update the job time limit using 
```
> scontrol update jobid=yyyyyy TimeLimit=D-HH:MM:SS
```