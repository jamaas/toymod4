rm(list=ls(all=TRUE))
## remove package in memory
detach("package:toymod4", unload=TRUE)
library(toymod4)
## load MPI cluster
cl <- doMPI::startMPIcluster(count=6)
doMPI::registerDoMPI(cl)
## set up the lists of parameters
fun1.params <- list(num.sim = 10, num.per = 8, num.day = 5)
fun2.params <- list(fun22on = TRUE, var21 = 0.5, var22 = 5)
fun31.params <- list(fun3on = TRUE, var31 = 500)
fun32.params <- list(fun3on = TRUE, var31 = 183)

## run a first simulation with default values
(fun1(fun2.params, fun31.params, fun32.params,
      num.sim = 10, num.per = 8, num.day = 5))

## change a level 3 function value and see if it changes results
fun2.params <- list(fun22on = FALSE, var21 = 0.5, var22 = 5)
(fun1(fun2.params, fun31.params, fun32.params, num.sim = 10,
      num.per = 8, num.day = 5))

## change a level 3 function value and see if it changes results
fun2.params <- list(fun22on = TRUE, var21 = 0.5, var22 = 5)
fun31.params <- list(fun3on = TRUE, var31 = 500)
fun32.params <- list(fun3on = FALSE, var31 = 500)
(fun1(fun2.params, fun31.params, fun32.params, num.sim = 10,
      num.per = 8, num.day = 5))

## change a level 3 function value and see if it changes results
fun2.params <- list(fun22on = TRUE, var21 = 0.5, var22 = 20)
fun31.params <- list(fun3on = TRUE, var31 = 500)
fun32.params <- list(fun3on = FALSE, var31 = 500)
(fun1(fun2.params, fun31.params, fun32.params, num.sim = 10,
      num.per = 8, num.day = 5))

## close down the cluster
doMPI::closeCluster(cl)
