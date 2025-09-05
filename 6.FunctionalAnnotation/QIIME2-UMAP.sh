#!/usr/bin/env bash 

biom convert -i protein-family-matrix.tsv -o protein-family-table.biom --to-hdf5
qiime tools import --type 'FeatureTable[PresenceAbsence]' --input-path protein-family-table.biom --output-path protein-family-table.qza 
qiime diversity-lib jaccard --i-table protein-family-table.qza --p-n-jobs 20 --o-distance-matrix protein-family-jaccard.qza 
qiime umap embed --i-distance-matrix protein-family-jaccard.qza --p-n-neighbors SAMPLE_NUMBER --o-umap protein-family-jaccard_umap.qza
