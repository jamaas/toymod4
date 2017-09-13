rm(list=ls(all=TRUE))

detach("package:toymod3", unload=TRUE)
library(toymod3)

library(doParallel)
cl <-makeCluster(10)
registerDoParallel(cl)
##cl <- doMPI::startMPIcluster(count=10)
##doMPI::registerDoMPI(cl)
##doMPI::exportDoMPI(cl, c('fun2', 'fun3'))

replicate(5, (fun3()))

replicate(5, (fun3(fun3on=FALSE)))

replicate(5, (fun3(fun3on=TRUE)))

(fun1(fun3on=FALSE))

search()


(fun3(fun3on = TRUE))

(fun1())

(stuff1 <- replicate(10, mean(unlist(fun1()))))

(stuff1 <- replicate(10, mean(unlist(fun1(fun3on=FALSE)))))


stopCluster(cl)
doMPI::closeCluster(cl)

q()
