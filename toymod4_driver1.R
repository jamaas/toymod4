rm(list=ls(all=TRUE))
## remove package in memory
detach("package:toymod4", unload=TRUE)
suppressMessages(library(doMPI))
library(toymod4)

## load MPI cluster
cl <- doMPI::startMPIcluster(count=6)
doMPI::registerDoMPI(cl)

fun2vars <- list(fun22on = TRUE, var21 = 0.5, var22 = 5)
fun3vars <- list(fun3on =TRUE, var31 = 500)
fun4vars <- list(var41 = 36.7256, fun4on = TRUE)

## set values for all regular arguments required
regargs(fun2vars = fun2vars,
        fun3vars = fun3vars,
        fun4vars = fun4vars)

## run the top level function which calls the others
fun1(num.sim = 5, num.per = 4, num.day = 50)

fun4vars <- list(fun4on = FALSE, var41 = 36.0)

## set values for all regular arguments required
regargs(fun2vars = fun2vars,
        fun3vars = fun3vars,
        fun4vars = fun4vars)

## run the top level function which calls the others
fun1(num.sim = 5, num.per = 4, num.day = 50)

fun4vars <- list(fun4on = TRUE, var41 = 10036.0)
regargs(fun2vars = fun2vars,
        fun3vars = fun3vars,
        fun4vars = fun4vars)
fun1(num.sim = 5, num.per = 4, num.day = 50)

closeCluster(cl)
mpi.quit()

