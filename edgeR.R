library(edgeR)  #load edger package
x <- read.table("count.table.nt.txt", header = TRUE, sep ="\t", row.names=1)
bcv <- 0.4  #human=0.4
group = c(rep("n", 5), rep("t", 44))
y <- DGEList(counts=x, group=group)
et <- exactTest(y, dispersion=bcv^2)
write.table(et$table,sep='\t', file='thymoma_edgeR_NT.txt')


x <- read.table("count.table.thymic_carcanimo.thymomas.txt", header = TRUE, sep ="\t", row.names=1)
bcv <- 0.4  #human=0.4
group = c(rep("TC", 18), rep("T", 26))
y <- DGEList(counts=x, group=group)
et <- exactTest(y, dispersion=bcv^2)
write.table(et$table,sep='\t', file='thymoma_edgeR_TC_T.txt')
