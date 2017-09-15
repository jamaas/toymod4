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
do.call(fun1,(c(list(fun31.params = fun31.params,
                    fun32.params = fun32.params,
                    fun2.params = fun2.params),
               fun1.params)))

## change a level 1 argument value and see if it changes
fun1.params <- list(num.sim = 10, num.per = 20, num.day = 5)
do.call(fun1,(c(list(fun31.params = fun31.params,
                    fun32.params = fun32.params,
                    fun2.params = fun2.params),
               fun1.params)))


## change a level 2 function value and see if it changes results
fun2.params <- list(fun22on = FALSE, var21 = 0.5, var22 = 5)
fun1.params <- list(num.sim = 10, num.per = 8, num.day = 5)
do.call(fun1,(c(list(fun31.params = fun31.params,
                    fun32.params = fun32.params,
                    fun2.params = fun2.params),
               fun1.params)))


## change a level 3 function value and see if it changes results
fun2.params <- list(fun22on = TRUE, var21 = 0.5, var22 = 5)
fun31.params <- list(fun3on = TRUE, var31 = 500)
fun32.params <- list(fun3on = FALSE, var31 = 500)
do.call(fun1,(c(list(fun31.params = fun31.params,
                    fun32.params = fun32.params,
                    fun2.params = fun2.params),
               fun1.params)))


## close down the cluster
doMPI::closeCluster(cl)
