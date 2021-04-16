### GSEA
library(edgeR)
counts <- read.delim("FAT2_readcount.txt", row.names = 1)
head(counts)

#d0 <- DGEList(counts)
#y = calcNormFactors(d0)
#GSEA_table <- cpm(y, log=TRUE)
GSEA_table <- cpm(counts)
head(GSEA_table)
thresh <- GSEA_table > 0.5
head(thresh)
table(rowSums(thresh))
keep <- rowSums(thresh) >= 2
counts.keep <- counts[keep,]
summary(keep)
dim(counts.keep) #각 몇개씩 되어있는지 보기위해
plot(myCPM[,1],countdata[,1])


#convert counts to DGEList object
d0 <- DGEList(counts.keep)
d0
y = calcNormFactors(d0) #normalization
GSEA_table <- cpm(y, log=TRUE)

write.table(GSEA_table, file='gsea.input.filtered.txt', sep='\t',quote = FALSE)