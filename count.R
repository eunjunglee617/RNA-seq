## make data.frame for each htseq-count files for normal
count_files_n = list.files(path = "./normal/", pattern = "*.TableOfCounts.txt")
first.sample.n = read.delim(paste0('./normal/',count_files_n[1]), header = F, row.names = 1)
count.table.n = data.frame(first.sample.n)
samples.n = gsub(".Table.*","", count_files_n)

for(i in count_files_n[2:length(count_files_n)]){
  fname_n = paste0('./normal/', i)
  column.n = read.delim(fname_n, header = F, row.names = 1)
  count.table.n = cbind(count.table.n, s = column.n)
}
colnames(count.table.n) = samples.n


## make data.frame for each htseq-count files for tumor
count_files = list.files(path = ".", pattern = "*.TableOfCounts.txt")
samples = gsub(".Table.*","", count_files)

first.sample = read.delim(paste0(count_files[1]),header=F,row.names=1) ##경로 + 파일명 합쳐서 불러오고싶을 때
count.table = data.frame(first.sample)

for(s in count_files[2:length(count_files)]){
  #print(s)
  print(which(count_files %in% s))
  fname = s
  column = read.delim(fname, header=F, row.names=1)
  count.table = cbind(count.table, s=column)
}
colnames(count.table) = samples


## combine normal & tumor
count.table.nt = cbind(count.table.n, count.table)
#colnames(count.table.nt) = c(rep("n", 5), rep("t", 44))
head(count.table.nt)


##save file
write.csv(count.table.nt, "count.table.nt.csv")
write.table(count.table.nt, file="count.table.nt.txt", sep = "\t")
write.table(count.table.nt, file="count.table.nt.gsea.txt", sep = "\t")
