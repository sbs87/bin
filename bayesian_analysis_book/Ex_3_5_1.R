rm(list=ls())
setwd("/Users/stevensmith/bin/bayesian_analysis_book")
# Goal: Toss a coin N times and compute the running proportion of heads. 
N= 100  #Specify the total number of flips
# Generate a random sample of N flips for a fair coin (heads=1, tails=0)
# the function "sample" is a part of R
#set.seed(47405) #uncomment to set seed of random number generator
pHeads=0.8 #Excerise 3.1, change p(H)=0.8
flipsequence=sample(x=c(0,1),prob=c(1-pHeads, pHeads),size=N,replace=TRUE)
#Compute the running proportion of heads:
r = cumsum(flipsequence)
n=1:N
runprop=r/N
# Graph the running proportion:
help('par')
plot(n, runprop,type="o",log="x",
     xlim=c(1,N),
     ylim=c(0.0,1.0),
     cex.axis=1.5,
     xlab="Flip Number",
     ylab="Proportion Heads",
     cex.lab=1.5,
     main="Running Proportion of Heads",cex.main=1.5)
# Plot a reference line at 0.5
lines(c(1,N),c(0.5, 0.5), lty=3)
# Display the beggining of the flip sequence. 
flipletters=paste(c("T","H")[flipsequence[1:10]+1],collapse="")
displaystring=paste("Flip Sequence= ",flipletters, "...",sep="")
text(5,.9,displaystring,adj=c(0,1),cex=1.3)
# Display the relative frequency at the end of the sequence.
text(N,0.3,paste("End Proportion=",runprop[N]),adj=c(1,0),cex=1.3)
# Save the plot to an EPS file.
dev.copy2eps(file="RunningProportions.eps")
