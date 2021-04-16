library(readxl)
library(xlsx)
library(dplyr)

##Differential expression 값 불러오기
logfc.nt <- read.delim("thymoma_edgeR_NT.txt", header = T)
logfc.tct <- read.delim("thymoma_edgeR_TC_T.txt", header = T)


##TPM 값들 불러오기
tpm.n <- read.delim(file = paste0('../', "genes.tpm.final_normal.txt"), sep = "\t", header = T)
tpm.t <- read.delim(file = paste0('../', "genes.tpm.final3_tumor.txt"), sep = "\t", header = T)

##logFC 값에 TPM 붙혀넣기 
logfc.nt.tpm <- merge(logfc.nt, tpm.n, by = "gene_id", all = TRUE)
logfc.nt.tpm <- merge(logfc.nt.tpm, tpm.t, by = "gene_id", all = TRUE)

logfc.tct.tpm <- merge(logfc.tct, tpm.t, by = "gene_id", all = TRUE)

##파일로 저장 
#write.csv(logfc.nt.tpm, "logFC.TPM.NT.csv", row.names = FALSE)
#write.csv(logfc.tct.tpm, "logFC.TPM.TCT.csv", row.names = FALSE)

logfc.nt.tpm2 <- logfc.nt.tpm %>% filter(logfc.nt.tpm$logFC >= 1.5)
logfc.nt.tpm2 <- logfc.nt.tpm2 %>% filter(logfc.nt.tpm2$PValue < 0.05)

logfc.tct.tpm2 <- logfc.tct.tpm %>% filter(logfc.tct.tpm$logFC >= 1.5)
logfc.tct.tpm2 <- logfc.tct.tpm2 %>% filter(logfc.tct.tpm2$PValue < 0.05)

##파일로 저장 
#write.csv(logfc.nt.tpm2, "logFC.TPM.NT_logfc1.5_p0.05.csv", row.names = FALSE)
#write.csv(logfc.tct.tpm2, "logFC.TPM.TCT_logfc1.5_p0.05csv", row.names = FALSE)


##nt의 gene들 제외한 tct의 고유한 값 추출 
nt.genes = unique(logfc.nt.tpm2$gene_id)
tct.genes = unique(logfc.tct.tpm2$gene_id)
length(nt.genes)
length(tct.genes)

tct.only = tct.genes[!(tct.genes %in% nt.genes)]
#tct2 = tct.genes[(tct.genes %in% nt.genes)]

logfc.tct.filtered <- c()
for(gene in tct.only){
  logfc.tct.filtered = rbind(logfc.tct.filtered, subset(logfc.tct.tpm2, logfc.tct.tpm2$gene_id == gene))
}
table(logfc.tct.filtered$gene_id)

##파일로 저장 
#write.csv(logfc.tct.filtered, "logFC.TPM.TCT.filtered.csv", row.names = FALSE)
