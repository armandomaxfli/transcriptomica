getwd()
if(!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("topGO")


library(topGO)
library(ggplot2)

#Pruebas =======
genes <- read.csv("desktop/secuencias_amphidinium/anotaciones/20vs40/lista_downreg_20vs40_eggNOG.csv", header = FALSE)$V1
file_background <- "Desktop/secuencias_amphidinium/anotaciones/Amphi_GOs.txt"

genes_interes <- as.factor(genes)

GOesByID <- readMappings(file = file_background)
bg_genes <- names(GOesByID)

compared_genes <- factor(as.integer(bg_genes %in% genes_interes))
names(compared_genes) <- bg_genes

GOdata <- new("topGOdata",
              ontology = "MF",
              allGenes = compared_genes,
              annot = annFUN.gene2GO,
              gene2GO = GOesByID)

fisher_resul <- runTest(GOdata,
                        algorithm = "classic",
                        statistic = "Fisher")              

allRes <- GenTable(GOdata, classicFisher = fisher_resul, topNodes = 45)
allRes

library(ggplot2)

allRes$classicFisher <- as.numeric(allRes$classicFisher)

ggplot(allRes, aes(x = Significant, y = Term, fill = classicFisher)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_classic()

#análisis enriquecimiento ====

#abrir los archivos de trabajo
genes <- read.csv("anotaciones/20vs30/Lista_upreg_20vs30_GOs.csv",
                              header = FALSE)$V1
file_background <- "anotaciones/Amphi_GOs.txt"

#Obtener los IDs para el análisis
genes_interes <- as.factor(genes)

#Obtener el backgorund de las anotaciones
GOsByID <- readMappings(file = file_background)
bg_genes <- names(GOsByID)

#comparación de los genes con el background genes
compared_genes <- factor(as.integer(bg_genes %in% genes_interes))
names(compared_genes) <- bg_genes

#Crea un objeto de topGO
GOdata <- new("topGOdata",
              ontology = "CC",
              allGenes = compared_genes,
              annot = annFUN.gene2GO,
              gene2GO = GOsByID)

#corre en test de Fisher
fisher_result <- runTest(GOdata,
                         algorithm = "classic",
                         statistic = "Fisher")

#crea una tabla con los resultados del análisis de enriquecimiento
allRes <- GenTable(GOdata,
                   classicFisher = fisher_result,
                   topNodes = 40)

#Gráficas de barras resultados

allRes$classicFisher <- as.numeric(allRes$classicFisher)

GO_plot <- ggplot(allRes, aes(x = Significant, y = Term, fill = classicFisher)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_classic() +
  labs(x = "Number of contigs", y = "Celular component",
       fill = "P-value")

ggsave("anotaciones/20vs30/up_CC.jpg", plot = GO_plot, dpi = 300)

#reducción de los terminos =====
library(rrvgo)

SimMatrix <- calculateSimMatrix(allRes$GO.ID,
                                orgdb = "org.At.tair.db",
                                ont = "CC",
                                method = "Rel")
scores <- setNames(-log10(allRes$classicFisher), allRes$GO.ID)

reducedTerms <- reduceSimMatrix(SimMatrix,
                                scores,
                                threshold = 0.7,
                                orgdb = "org.At.tair.db")

allRes_reduced <- allRes[allRes$GO.ID %in% reducedTerms$parent, ]
