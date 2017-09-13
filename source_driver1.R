rm(list=ls(all=TRUE))

## cl <- doMPI::startMPIcluster(count=4)
## doMPI::registerDoMPI(cl)
library(doParallel)
cl <-makeCluster(5)
registerDoParallel(cl)

## library(toymod3)
lapply(list.files(path="./R", pattern = ".R", full.names = TRUE,
                  recursive = TRUE), source)

fun3on = TRUE
var31 = 500
(fun1())

var31 = 300
(fun1())

fun3on = FALSE
(fun1())

fun3on = TRUE
var31=500
(fun1(num.sim=8))

fun3on=TRUE
(fun1())

stopCluster(cl)
doMPI::closeCluster(cl)
