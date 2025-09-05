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

### 3.Binning
> * **1.Contig_align.sh**
>   Builds an index and aligns the reads to assembled contigs
> * **2.metaBAT2.sh**
>   Initiates metaBAT2 binning pipeline
> * **3.MaxBin2.sh**
>   Initiates MaxBin2 binning pipeline
> * **4.CONCOCT.sh**
>   Initiates CONCOCT binning pipeline 
> * **merge_cutup_clustering.py**
>   Combines subcontig-level clustering results back into the original contig-level clustering for CONCOCT
> * **5.MetaWRAP.sh**
>   Initiates MetaWRAP bin refinement pipeline  
> * **define_quality.py**
>   Summarize genome quality report of MetaWRAP
> * **6.GUNC.sh**
>   Initiates GUNC chimerism detection pipeline 
> * **GTDB-tk2_classify.sh** 
>   Classify genomes with GTDB-Tk2 
> * **barrnap_tRNAscan-SE.sh** 
>   Initiates barrnap and tRNAscan-SE2
> * **checkM-CPR.sh**
>   Genome quality estimation for Patescibacteria
> * **checkM-taxonomy_wf.sh** 
>   Genome quality estimation using checkM and universal bacterial marker gene set
> * **summarize_checkm-result.py**
>   Summarize checkM Result
> * **summarize-barrnap.py**
>   Summarize barrnap Result
> * **summarize-tRNAscan.py**
>   Summarize tRNAscan Result

### 4.Dereplication
> * **NUCMER.sh**
>   Initiates nucmer for pairwise coverage & ANI calculation
> 


> * **NUCMER.sh**
>   설명 
> * **코드**
>   설명 

