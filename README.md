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
>   Run MetaWRAP bin refinement pipeline  
> * **define_quality.py**
>   Summarize genome quality report of MetaWRAP
> * **6.GUNC.sh**
>   Run GUNC chimerism detection pipeline 
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
> * **cal_nucmer.py**
>   Calculates pairwise alignment coverage & ANI from nucmer output 
> * **dRep-MASH.sh** 
>   Initiates MASH clustering using dRep compare module
> * **hierarchical_clustering.R* 
>   Species-level hierarchical clustering using alignment coverage & ANI
> * **summarize_cluster.py**
>   summarize species-level clustering and set representative genome 

### 5.Protein_catalogue
> * **Prokka.sh**
>   Initiates Prokka for Protein sequence estimation
> * **MMseqs2-linclust.sh** 
>   Clustering all HROM proteins at a specified percentage identity using MMseqs2 
> * **eggNOG-mapper.sh**
>   Funtional annotation of protein catalog using eggNOG mapper

### 6.FunctionalAnnotation
> * **Anvio-kofam-metabolism.sh**
>   Anvi'o pipeline to estimate metabolism module completeness
> * **Anvi-metabolic-independence.py**
>   Estimate metabolic independence score from metabolism module completeness result from Anvi'o 
> * **33_Module.list** 
>   List of predefined 33 metabolism module for estimation of metabolic independence score
> * **DefenseFinder.sh** 
>   Run DefenseFinder for viral defense system estimation
> * **MacSyFinder.sh**
>   Run MacSyFinder for Type IV pilus system gene annotation 
> * **Panaroo.sh**
>   Run Panaroo for species-level pangenome construction 
> * **QIIME2-UMAP.sh**
>   UMAP ordination of Patescibacteria genomes based on Jaccard distance derived from protein presence/absence profiles
> * **RGI.sh**
>   Run RGI for Antibiotic resistance gene annotation
> * **Sporulation-tblastn.sh** 
>   Run tblastn to 65 marker genes related to Sporulation score 
> * **Sporulation-summarize.py** 
>   Summarize sporulation gene hits from tblastn result 
> * **gutSMASH.sh**
>   Run gutSMASH for metabolic gene cluster annotation
> * **pyrodigal.sh** 
>   Run pyrodigal for small peptide estimation 
> * **filter-pyrodigal.py** 
>   Retain small peptides that fall within the specified length threshold
> * **hmmAntiFam.sh**
>   Run hmmsearch using Antifam profiles on small peptides to remove spurious proteins 
> * **summarize-Antifam.py**
>   Summarize Antifam result for subsequent removal
> * **Macrel.sh** 
>   Run Macrel for AMP estimation from non-spurious small peptides



> * **NUCMER.sh**
>   설명 
> * **코드**
>   설명 

