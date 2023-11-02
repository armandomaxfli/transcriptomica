install.packages("ggplot2")
install.packages("ggpubr")
install.packages("agricolae")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.17")

library(BiocManager)

BiocManager::install("DESeq2")
Y
library(DESeq2)

BiocManager::install("apeglm")
library(apeglm)
library(dplyr)

getwd()

#cargamos los datos

datos <- read.csv("secuencias_amphidinium/Trinity_isoform_counts_matrix.csv",
                  header = TRUE, row.names = 1)
colnames(datos)
head(datos)

info <- read.table("secuencias_amphidinium/archivos_slrm/colData.txt",
                   header = TRUE, sep = '\t')

dds <- DESeqDataSetFromMatrix(countData =  datos, 
                              colData = info,
                              design = ~tratamiento)

#elimininamos genes con baja expresión

keep <- rowSums(counts(dds)) >= 5
dds <- dds[keep,]


#main DEseq
ddsDE <- DESeq(dds)

#contraste entre tratamientos
contrast_30vs40 <- c("tratamiento", "30psu", "40psu")
contrast_30vs20 <- c("tratamiento", "30psu", "20psu")
contrast_40vs20 <- c("tratamiento", "40psu", "20psu")

#realiza las comparaciones
res_30vs40 <- results(ddsDE, contrast = contrast_30vs40)
res_30vs20 <- results(ddsDE, contrast = contrast_30vs20)
res_40vs20 <- results(ddsDE, contrast = contrast_40vs20)


#accede a los resultados
summary(res_30vs40)
summary(res_30vs20)
summary(res_40vs20)

#cambia el objeto DESeq a un dataframe de R
#este es opcional, si lo aplico ya no puedo ver el porcentaje
#de genes diferencialmente expresados

res_30vs40 <- as.data.frame(res_30vs40)
res_30vs20 <- as.data.frame(res_30vs20)

#export normalized read counts
normCounts <- counts(ddsDE, normalized = TRUE)
write.csv(normCounts, "desktop/secuencias_amphidinium/salinidad.csv")

#output DESeq results
resOrdered_30vs20 <- res_30vs20[order(res_30vs20$padj),]
write.csv(resOrdered_30vs20, "desktop/secuencias_amphidinium/deSeq30vs20.csv")

resOrdered_30vs40 <- res_30vs40[order(res_30vs40$padj),]
write.csv(resOrdered_30vs40, "desktop/secuencias_amphidinium/deSeq30vs40.csv")

resOrdered_40vs20 <- res_40vs20[order(res_40vs20$padj),]
write.csv(resOrdered_40vs20, "desktop/secuencias_amphidinium/deSeq40vs20.csv")

resultsNames(ddsDE)

#extraer los genes más expresados diferencialmente
#Seleccionar los genes con un cambio significativo in la expresion (p-value < 0,05)
#Y log2Fold change <1 y >1

#paso 1: filtrar basado en el p adjusted value
filtrado_40vs30 <- res_30vs40 %>% filter(res_30vs40$padj < 0.05)

#paso 2: filtrar basado en el fold change. usando un threshold de 1
 #upregulated
upregulated_40vs30 <- filtrado_40vs30 %>% filter(abs(filtrado_40vs30$log2FoldChange) > 1)
write.csv(upregulated_40vs30, "secuencias_amphidinium/upregulated_40vs30.csv")

 #downregulated
dowregulated_40vs30 <- filtrado_40vs30 %>% filter(abs(filtrado_40vs30$log2FoldChange) < 1)
write.csv(dowregulated_40vs30, "secuencias_amphidinium/DESeq/downregulated_40vs30.csv")

#dispersión

plotDispEsts(ddsDE)


install.packages("pheatmap")
library(pheatmap)
library(ggplot2)
library(ggrepel)

#PCA plots
#variance stabilization transformation
vsd <- vst(ddsDE, blind = FALSE)

plotPCA(vsd, intgroup = c("tratamiento"))

#heatmaps

#heatmap pf sample-to-sample distance matrix based on the normalized counts

#generate distance matrix
sampleDist <- dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDist)

#generate the heatmap
pheatmap(sampleDistMatrix, clustering_distance_rows = sampleDist,
         clustering_distance_cols = sampleDist)

#heatmap of log transformed normalized counts
