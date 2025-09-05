#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
library(fastcluster)
library(igraph) 


distance_txt <- read.csv(args[1] ,sep = '\t' ,header = FALSE)
colnames(distance_txt) <- c("V1","V2","weight","alignment_coverage")
thr <- 0.3
if (TRUE %in% unique(distance_txt$alignment_coverage < thr)) {
	distance_txt[which(distance_txt$alignment_coverage < thr ), ]$weight <- 0
}
distance_txt$alignment_coverage <- NULL 
distance_txt$weight <- 1 - distance_txt$weight

hc <- fastcluster::hclust(as.dist(as.matrix(as_adjacency_matrix(graph.data.frame(distance_txt,directed = FALSE), attr = "weight" , sparse = T))), method = 'average')

sub_grp <- cutree(hc, h = 0.05)
answer <- cbind(names(sub_grp),paste('secondary_cluster',sub_grp,sep =  '_' ))
write.table(answer, args[2] ,sep = '\t' , quote = FALSE,row.names = FALSE,col.names = FALSE)
