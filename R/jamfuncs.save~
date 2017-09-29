#' Test function level 1
#' @param num.sim first variable for function 1
#' @param num.per second variable for function 1
#' @param num.day third variable for function 1
#' @export fun1

fun1 <- function (fun2.params, fun31.params, fun32.params, fun4.params,
                  num.sim=10, num.per=8, num.day=5, ...) {
    final.results <- data.frame (foreach::`%dopar%`(
        foreach::`%:%`(foreach::foreach(j = 1:num.sim,
                                        .combine = cbind,
                                        .packages= "toymod4"),
                       foreach::foreach (i = 1:num.per, .combine=rbind)),
        {
            out3 <- replicate(num.day,
                              do.call(fun2,
                                      c(list(fun31.params=fun31.params,
                                             fun32.params=fun32.params,
                                             fun4.params = fun4.params),
                                             fun2.params)))
            out2 <- data.frame(mean(out3))
        }
    )
    )
    ## save outputs for subsequent analyses if required
    saveRDS(final.results, file = paste("./outputs/", num.day ,"_",
                                        num.per, "_", num.sim, "_",
                                        format(Sys.time(), "%d_%m_%Y"),
                                        ".rds", sep=""))
    return(final.results)
}

#' Test function level 2
#' @param var21 first variable for function 2
#' @param var22 second variable for function 2
#' @param fun22on turn this copy of fun3 on or off
#' @export fun2

fun2 <- function (fun31.params, fun32.params, fun4.params,
                  var21, var22, fun22on, ...) {
    out21 <- ifelse (rpois(1, var21) > 0,
                     var22 * do.call(fun3, c(list(fun4.params=fun4.params),
                                             fun31.params)),
                     0)

    out22 <- ifelse (fun22on,
                     do.call(fun3, c(list(fun4.params=fun4.params),
                                     fun32.params)),
                     0)

    out2 <- out21 + out22
}

#' Test function level 3
#' @param var31 first variable for function 3
#' @param fun3on turn the formula on or off
#' @export fun3

fun3 <- function (fun3on, var31, fun4.params, ...) {
    out31 <- ifelse (fun3on, var31, 1)
    out32 <- ifelse (fun3on, do.call(fun4, fun4.params), 0)
    out3 <- out31 + out32
}

#' Test function level 4
#' @param var41 first variable for function 4
#' @param fun4on turn the formula on or off
#' @export fun4

fun4 <- function (fun4on, var41, ...) {
    out4 <- ifelse (fun4on, var41, 1)
}

