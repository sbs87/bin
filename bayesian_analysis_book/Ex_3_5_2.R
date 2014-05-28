#Graph of normal probability density function, with comb of intervals. From "Doing Bayesian Analysis", John Kruschke, 2011, pg 48-9 Section 3.5.2. 
#Transcribed by Steven Smith, Sept 22, 2013. 
setwd("/Users/stevensmith/bin/bayesian_analysis_book")
meanval=0.0             #Specify mean
sdval=0.2               #Specify standard deviation
xlow=meanval-3*sdval    #Specify low end of plot
xhigh=meanval+3*sdval   #Specify high end of plot
#xlow=meanval-1*sdval    #Used for exercise 3.4
#xhigh=meanval+1*sdval   #Used for exercise 3.4
#xlow=0                  #Used for excersie 3.2
#xhigh=1                 #Used for excersie 3.2
dx=0.02                 #Specify interval width of x axis
#Specify comb points along x axis:
x=seq(from=xlow,to=xhigh,by=dx)
#Compute y values using normal density function, i.e., the probability density at each value of x:
y=(1/(sdval*sqrt(2*pi)))*exp(-0.5*((x-meanval)/sdval)^2)
#An alternative probability density function, for use with excersize 3.3, pg 49. Change xhigh and xlow appropriatley:
#y=6*x*(1-x)
#Plot the values. Plot draws invervals. Lines draws the bell curve.  
plot(x,y,type="h",lwd=1,cex.axis=1.5,xlab="x",ylab="p(x)",cex.lab=1.5,main="Normal Probability Density",cex.main=1.5)
lines(x,y)
#Estimate area by summing over each inverval of x each y (p(x)). This is integral of sum(width*height):
area=sum(dx*y)
#Display info on plot.These need to be adusted if doing Ex 3.2:
text(-sdval,.9*max(y),bquote(paste(mu,"=",.(meanval))),adj=c(1,.5))
text(-sdval,.8*max(y),bquote(paste(sigma,"=",.(sdval))),adj=c(1,.5))
text(sdval,.9*max(y),bquote(paste(Delta,"=",.(dx))),adj=c(0,.5))
text(sdval,.8*max(y),bquote(paste(sum(,x,)," ",Delta,"x p(x)=",.(signif(area,3)))),adj=c(0,.5))
#Save the plot to an EPS file:
dev.copy2eps(file="IntegralOfDensity.eps")