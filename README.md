# HROM Code repository
This repository contains code used for HROM construction.

## Code description
### 1.read_QC
> * **1.Trimmomatic_PE.sh**
>   Trims adapter sequences and filters out low-quality bases from Illumina sequencing reads
> * **2.Bowtie2.sh**
>   Maps sequencing reads to the human reference genome and discards those aligning reads as human-derived contaminants

### 2.assembly
> * **1.MEGAHIT.sh**
>   Constructs contigs/scaffolds from quality-controlled reads using MEGAHIT
> * **1.metaSPAdes.sh**
>   Constructs contigs/scaffolds from quality-controlled reads using metaSPAdes
> * **change-contig-name-megahit.py**
>   Changes contig header of MEGAHIT for downstream analysis

### 2.assembly



