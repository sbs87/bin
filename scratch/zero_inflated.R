preg<-read.table("/Users/stevensmith/bin/scratch/preg_data.txt",sep="\t",header=T)
head(preg)
preg$non_zero<-preg$Y>0
(preg_ZC<-table(data.frame(preg$Spec,preg$non_zero))/9)
preg_ZC.df<-data.frame(preg_ZC)
rowSums(preg_ZC)
library(ggplot2)
ggplot(preg_ZC.df)+geom_bar(aes(x=preg.Spec,y=Freq,fill=preg.non_zero),stats="identity")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
