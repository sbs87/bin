HDIofICDF=function(ICDFname, credMass=0.95,tol=1e-8,...){
  #Arguments:
  #ICDname is R's name for the inverse cumulative density function of the distibution
  #credMass is the desired mass of the HDI region
  #tol is passed to R's optimize functiin.
  #Return value:
  #Highest desnity interval (HDI) limits in a vector.
  #Example of use: For determining HDI of a beta(30,12) distribution, type HDIofICDF(qBeta,shape1=30,shape2=12)
  #Notice that the parameter of the ICDFname must be explicity names: e.e., HDIofICDF(qBeta,30,12) does not work
  #Adapted and corrected from Greg Snow's teachingDemo's package.
  incredMass=1.0-credMass
  intervalWidth=function(lowTailPr,ICDFname,credMass,...){
    ICDFname(credMass+lowTailPr,...)-ICDFname(lowTailPr,...)
  }
  optInfo=optimize(intervalWidth,c(0,incredMass),ICDFname=ICDFname, credMass=credMass,tol=tol, ...)
  HDIlowTailPr=optInfo$minimum
  return(c(ICDFname(HDIlowTailPr,...),ICDFname(credMass+HDIlowTailPr,...)))
}