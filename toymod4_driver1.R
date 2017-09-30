rm(list=ls(all=TRUE))
## remove package in memory
detach("package:toymod4", unload=TRUE)
suppressMessages(library(doMPI))
library(toymod4)

## load MPI cluster
cl <- doMPI::startMPIcluster(count=6)
doMPI::registerDoMPI(cl)

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

