rm(list=ls(all=TRUE))
## remove package in memory
detach("package:toymod4", unload=TRUE)
suppressMessages(library(doMPI))
library(toymod4)

## load MPI cluster
cl <- doMPI::startMPIcluster(count=6)
doMPI::registerDoMPI(cl)

## set values for all regular arguments required
regargs(fun22on = TRUE, var21 = 0.5, var22 = 5, 
        var31 = 500, fun3on = TRUE,
        var41 = 36.3, fun4on = TRUE)

## run the top level function which calls the others
fun1(num.sim = 10, num.per = 8, num.day = 5)

fun1(num.sim = 12, num.per = 5, num.day = 5)

regargs(fun22on = FALSE, var21 = 0.5, var22 = 5, 
        var31 = 500, fun3on = FALSE,
        var41 = 36.3, fun4on = FALSE)

fun1(num.sim = 12, num.per = 5, num.day = 5)

regargs(fun22on = TRUE, var21 = 0.5, var22 = 5, 
        var31 = 500, fun3on = FALSE,
        var41 = 36.3, fun4on = FALSE)

fun1(num.sim = 12, num.per = 5, num.day = 5)
regargs(fun22on = TRUE, var21 = 0.5, var22 = 5, 
        var31 = 500, fun3on = TRUE,
        var41 = 36.3, fun4on = FALSE)

fun1(num.sim = 12, num.per = 5, num.day = 5)

closeCluster(cl)
mpi.quit()

## ## set up the lists of parameters
## fun1.params <- list(num.sim = 10, num.per = 8, num.day = 5)
## fun2.params <- list(fun22on = TRUE, var21 = 0.5, var22 = 5)
## fun31.params <- list(fun3on = TRUE, var31 = 500)
## fun32.params <- list(fun3on = TRUE, var31 = 183)
## fun4.params <- list(fun4on = TRUE, var41 = 36.3)

## ## run a first simulation with default values
## do.call(fun1,(c(list(fun4.params = fun4.params,
##                      fun31.params = fun31.params,
##                      fun32.params = fun32.params,
##                      fun2.params = fun2.params),
##                 fun1.params)))

## ## change a level 1 argument value and see if it changes
## fun1.params <- list(num.sim = 10, num.per = 20, num.day = 5)

## do.call(fun1,(c(list(fun4.params = fun4.params,
##                      fun31.params = fun31.params,
##                      fun32.params = fun32.params,
##                      fun2.params = fun2.params),
##                 fun1.params)))

## ## close down the cluster
## doMPI::closeCluster(cl)
