setwd("/home/santhosh/diffrential_expression_analysis")

# Load required libraries
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
  BiocManager::install("DESeq2")
}

# Install and load other required packages
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("pheatmap")) install.packages("pheatmap")

library(DESeq2)
library(tidyverse)
library(pheatmap)
library(ggplot2)


# Reading the files
SRR6040092_counts <- read.delim("/home/santhosh/DEseq2/SRR6040092_counts.txt",header=FALSE)
SRR6040093_counts <- read.delim("/home/santhosh/DEseq2/SRR6040093_counts.txt",header=FALSE)
SRR6040096_counts <- read.delim("/home/santhosh/DEseq2/SRR6040096_counts.txt", header=FALSE)
SRR6040094_counts <- read.delim("/home/santhosh/DEseq2/SRR6040094_counts.txt", header=FALSE)
SRR6040095_counts <- read.delim("/home/santhosh/DEseq2/SRR6040095_counts.txt",header =FALSE)
SRR6040097_counts <- read.delim("/home/santhosh/DEseq2/SRR6040097_counts.txt",header =FALSE)
SRR6156066_counts <- read.delim("/home/santhosh/DEseq2/SRR6156066_counts.txt",header =FALSE)
SRR6156067_counts <- read.delim("/home/santhosh/DEseq2/SRR6156067_counts.txt",header =FALSE)
SRR6156069_counts <- read.delim("/home/santhosh/DEseq2/SRR6156069_counts.txt",header =FALSE)

# Naming columns
names(SRR6040092_counts)[2]<- "MUSANGKINGLEAF"
names(SRR6040093_counts)[2]<- "MUSANGKINGROOT"
names(SRR6040096_counts)[2]<- "MUSANGKINGSTEM" 
names(SRR6040094_counts)[2]<- "MUSANGKINGARIL1"
names(SRR6040095_counts)[2]<- "MUSANGKINGARIL2"
names(SRR6040097_counts)[2]<- "MUSANGKINGARIL3"
names(SRR6156066_counts)[2]<- "MONTHONGARIL1"
names(SRR6156067_counts)[2]<- "MONTHONGARIL2"
names(SRR6156069_counts)[2]<- "MONTHONGARIL3"


# Merge data frames
countData <- merge(SRR6040092_counts, SRR6040093_counts, by="V1")
countData <- merge(countData,SRR6040096_counts, by="V1")
countData <- merge(countData,SRR6040094_counts, by="V1")
countData <- merge(countData,SRR6040095_counts, by="V1")
countData <- merge(countData,SRR6040097_counts, by="V1")
countData <- merge(countData,SRR6156066_counts, by="V1")
countData <- merge(countData,SRR6156067_counts, by="V1")
countData <- merge(countData,SRR6156069_counts, by="V1")




names(countData)[1] <- "gene"
view(countData)
countData <- countData[-c(1,2,3,4,5),]
view(countData)
head(countData)
type <- c("MUSANGKINGLEAF","MUSANGKINGROOT","MUSANGKINGSTEM","MUSANGKINGARIL1","MUSANGKINGARIL2","MUSANGKINGARIL3","MONTHONGARIL1","MONTHONGARIL2","MONTHONGARIL3")
names <- countData[,-1]
metaData <- data.frame(row.names=colnames(names), type)
countData <- data.frame(row.names=countData[,1], MUSANGKINGLEAF=countData[2], MUSANGKINGROOT=countData[3], MUSANGKINGSTEM=countData[4], MUSANGKINGARIL1=countData[5],MUSANGKINGARIL2=countData[6],MUSANGKINGARIL3=countData[7],MONTHONGARIL1=countData[8],MONTHONGARIL2=countData[9],MONTHONGARIL3=countData[10])

View(metaData)
View(countData)

# DESeq
dds <- DESeqDataSetFromMatrix(countData=countData, colData=metaData, design=~type)
dds <- DESeq(dds)
levels(dds$type)
# PCA
rld <- rlog(dds)


library(dplyr)
library(ggplot2)

colData(dds)$plotGroup <- with(colData(dds), ifelse(grepl("ARIL", type) & grepl("MUSANG", type), "MUSANG KING ARIL",
                                                    ifelse(grepl("ARIL", type) & grepl("MONTHONG", type), "MONTHONG ARIL",
                                                           ifelse(grepl("LEAF", type), "MUSANG KING LEAF",
                                                                  ifelse(grepl("ROOT", type), "MUSANG KING ROOT",
                                                                         ifelse(grepl("STEM", type), "MUSANG KING STEM", "OTHER"))))))
colData(dds)
colData(dds)$plotGroup <- factor(colData(dds)$plotGroup)
levels(colData(dds)$plotGroup) <- c("MUSANG KING ARIL", "MONTHONG ARIL", "MUSANG KING LEAF", "MUSANG KING ROOT", "MUSANG KING STEM", "OTHER")

# Prepare the PCA plot data
pcaData <- plotPCA(rlog(dds), intgroup = "plotGroup", returnData = TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))

#PCA plot with specified colors for each group
ggplot(pcaData, aes(x = PC1, y = PC2, color = plotGroup)) +
  geom_point(size = 3) +
  scale_color_manual(values = c("MUSANG KING ARIL" = "#d62728", 
                                "MONTHONG ARIL" = "#1f77b4", 
                                "MUSANG KING LEAF" = "#2ca02c",
                                "MUSANG KING ROOT" = "#ff7f0e",
                                "MUSANG KING STEM" = "#9467bd",
                                "OTHER" = "#e377c2")) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) 
  

  
#HEATMAP
dds <- estimateSizeFactors(dds)
select <- order(rowMeans(counts(dds, normalized=TRUE)), decreasing=TRUE)[1:20]
rld <- rlogTransformation(dds)
norm_counts <- assay(rld)[select,]
df <- as.data.frame(colData(dds)[, c("type", "sizeFactor")])
pheatmap(norm_counts,
         cluster_rows = TRUE,
         show_rownames = TRUE,
         cluster_cols = TRUE,
         annotation_col = df)
#select<-order(rowMeans(counts(dds,normalized=TRUE)),decreasing = TRUE)[1:20] 
#nt<-normTransform(dds)
#log2.norm.counts<-assay(nt)[select,]
#df<-as.data.frame(colData(dds))
#pheatmap(log2.norm.counts,cluster_rows = TRUE,show_rownames = TRUE,cluster_cols = TRUE,annotation_col = df)

#volcano plot
res <- results(dds, contrast=c("type", "fruit", "non-fruit"))  
res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

# differentiate significant results
res_df$significant <- ifelse(res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1, "yes", "no")

library(ggplot2)
volcano_plot <- ggplot(res_df, aes(x=log2FoldChange, y=-log10(pvalue), color=significant)) +
  geom_point(alpha=0.5)
print(volcano_plot)



