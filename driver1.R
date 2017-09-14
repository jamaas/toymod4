rm(list=ls(all=TRUE))

detach("package:toymod4", unload=TRUE)
library(toymod4)
library(pryr)

library(doParallel)
cl <-makeCluster(5)
registerDoParallel(cl)
##cl <- doMPI::startMPIcluster(count=10)
##doMPI::registerDoMPI(cl)
##doMPI::exportDoMPI(cl, c('fun2', 'fun3'))

final.calcs()

stopCluster(cl)
doMPI::closeCluster(cl)

q()
