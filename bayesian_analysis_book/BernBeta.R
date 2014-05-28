setwd("/Users/stevensmith/bin/bayesian_analysis_book")
BernBeta=function(priorShape, dataVec, credMass=0.95,saveGraph=F){
  #Bayseian updating for Benoulli liklihood and beta prior
  #input arguments:
  #priorShape
  #vector of parameter values for the prior beta distrbtion
  #dataVec
  #vector of 1's and 0's
  #credMass
  #the probability mass of the HDI
  #output:
  #postShape
  #vector of parameter values for the posterior distribution
  #Graphics:
  #creates a three-panel graph of prior, liklihood, and posterior with highest posterior desntiy interval
  #Examles of use:
  #> postShape =BernBeta (priorShape=c(1,1),dataVec=c(1,0,0,1,1))
  
  #Check for errors in input arguments:
  if(length(priorShape)!=2){
    stop("priorShape must have two components.")
  }
  if(any(priorShape<=0)){
    stop("priorShape components must be postive.")
  }
  if(any(dataVec!=1 & dataVec!=0)){
    stop("dataVec must be a vector of 1s and 0s.")
  }
  if(credMass<=0 | credMass>=1.0){
    stop("credMass must be between 0 and 1.")
  }
  
  #Rename the prior shape parameters, for convincence
  a=priorShape[1]
  b=priorShape[2]
  #Create summary values of the data:
  z=sum(dataVec==1) #Number of 1's in the dataVec
  N=length(dataVec) #Number of flips in dataVec
  #Compute the posterior shape parameters:
  postShape=c(a+z,b+N-z)
  #Compute the evidence, p(D):
  pData=beta(z+a,N-z+b)/beta(a,b)
  #Determine the limits of the highest density interval
  #This uses a home grown function alled HDIofICDF
  source("HDIofICDF.R")
  hpdLim=HDIofICDF(qbeta,shape1=postShape[1],shape2=postShape[2],credMass=credMass)
  
  #Now plot everything:
  #construct grid of theta values used for graphing:
  binwidth=0.005 #Arbitrary small value for comb on Theta
  Theta=seq(from=binwidth/2, to=1-(binwidth/2),by=binwidth)
  #Compute the prior at each value of theta.
  pTheta=dbeta(Theta,a,b)
  #Compute the kujekugiid if the data at each value of theta.
  pDataGivenTheta=Theta^z*(1-Theta)^(N-z)
  #Compute the posterior at each value of theta
  pThetaGivenData=dbeta(Theta,a+z,b+N-z)
  #Open a window with three panels
  quartz(7,10)
  layout(matrix(c(1,2,3),nrow=3,ncol=1,byrow=F)) #3x1 panels
  par(mar=c(3,3,1,0),mgp=c(2,1,0),mai=c(0.5,0.5,0.3,0.1)) #margin specs
  maxY=max(c(pTheta,pThetaGivenData)) #max y for plotting
  #plot the prior
  plot(Theta,pTheta,type="l",lwd=3,xlim=c(0,1),ylim=c(0,maxY),cex.axis=1.2,xlab=bquote(theta),ylab=bquote(p(theta)),cex.lab=1.5,main="Prior",cex.main=1.5)
  if(a>b){textx=0;textadj=c(0,1)}
  else{textx=1;textadj=c(1,1)}
  text(textx,1.0*max(pThetaGivenData),bquote("beta("*theta*"|"*.(a)*","*.(b)*")"),cex=2.0,adj=textadj)
  #Plot the likelihood:p(data|theta)
  plot(Theta,pDataGivenTheta,type="l",lwd=3,xlim=c(0,1),cex.axis=1.2,xlab=bquote(theta),ylim=c(0,1.1*max(pDataGivenTheta)),ylab=bquote("p(D|"*theta*")"),cex.lab=1.5, main="Likelihood",cex.main=1.5)
  if(z>.5*N){textx=0;textadj=c(0,1)}
  else{textx=1;textadj=c(1,1)}
  text(textx,1.0*max(pDataGivenTheta),cex=2.0,bquote("Data: z="*.(z)*",N="*.(N)),adj=textadj)
  #plot the posterior:
  plot(Theta,pThetaGivenData,type="l",lwd=3,xlim=c(0,1),ylim=c(0,maxY),cex.axis=1.2,xlab=bquote(theta),ylab=bquote("p("*theta*"|D)"),cex.lab=1.5,main="Posterior",cex.main=1.5)
  if(a+z > b+N-z){textx=0;textadj=c(0,1)}
  else{textx=1;textadj=c(1,1)}
  text(textx,1.00*max(pThetaGivenData),cex=2.0,bquote("beta("*theta*"|"*.(a+z)*","*.(b+N-z)*")"),adj=textadj)
  #Mark the HDI in the posterior
  hpdHt=mean(c(dbeta(hpdLim[1],a+z,b+N-z),dbeta(hpdLim[2],a+z,b+N-z)))
  lines(c(hpdLim[1],hpdLim[1]),c(-0.5,hpdHt),type="l",lty=2,lwd=1.5)
  lines(c(hpdLim[2],hpdLim[2]),c(-0.5,hpdHt),type="l",lty=2,lwd=1.5)
  lines(hpdLim,c(hpdHt,hpdHt),type="l",lwd=2)
  text(mean(hpdLim),hpdHt,bquote(.(100*credMass)*"% HDI"),adj=c(0.5,1),cex=2)
  #...continut later...
  
  #Construct file name for saved graph, and save the graph
  if(saveGraph){
    filename=paste("BernBeta_",a,"_",b,"_",z,"_",N,".eps",sep="")
    dev.copy2eps(file=filename)
  }
  return(postShape)
}#end of function

#Exercise 5.1.a
post=BernBeta(c(4,4),c(1))

#Exercise 5.1.b
post=BernBeta(post,c(1))

#Exercsie 5.1.c
post=BernBeta(post,c(0))

#Exercise 5.1.d
post=BernBeta(c(4,4),c(0))
post=BernBeta(post,c(1))
post=BernBeta(post,c(1))
#Order doesn't appear to matter
