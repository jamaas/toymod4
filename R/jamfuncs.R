#' Test function level 1
#' @param var11 first variable for function 1
#' @param var12 second variable for function 1
#' @param var13 third variable for function 1
#' @export fun1

fun1 <- function (var11=10, var12=8, var13=5,
                  var21=0.05, var22=9.876,
                  fun3on=TRUE, ...) {

    results <- data.frame (foreach::`%dopar%`(
            foreach::`%:%`(foreach::foreach(j = 1:var11,
                                            .combine = cbind,
                                            .packages="toymod2",
                                            .export = "fun3on"),
            foreach::foreach (i = 1:var12, .combine=rbind)),
                   out3 <- replicate(var13, do.call(fun2, list(var21, var22)))
        )
)
## save outputs for subsequent analyses if required
saveRDS(results, file = paste("./outputs/", var13 ,"_", var12, "_", var11, "_",
                              format(Sys.time(), "%d_%m_%Y"), ".rds", sep=""))
return(results)
}

#' Test function level 2
#' @param var21 first variable for function 2
#' @param var22 second variable for function 2
#' @export fun2

fun2 <- function (var21=0.05, var22=9.876, ...) {
    out2 <- `if` (rpois(1, var21) > 0,
                    var22 * fun3(...),
                  0)
}

#' Test function level 3
#' @param var31 first variable for function 3
#' @param var32 second variable for function 3
#' @param var33 third variable for function 3
#' @param fun3on turn the formula on or off
#' @export fun3

fun3 <- function (var31=1.396, var32=14.387,
                  var33=3.219, fun3on = TRUE, ...) {
    out3 <- `if` (fun3on,
                  var31 * rnorm(1, mean=var32, sd= var33),
                  500)
}
