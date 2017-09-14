#' Test function level 1
#' @param num.sim first variable for function 1
#' @param num.per second variable for function 1
#' @param num.day third variable for function 1
#' @export fun1

fun1 <- function (fun2.params, fun31.params, fun32.params, num.sim=10,
                  num.per=8, num.day=5, ...) {
    final.results <- data.frame (foreach::`%dopar%`(
        foreach::`%:%`(foreach::foreach(j = 1:num.sim,
                                        .combine = cbind,
                                        .packages= "toymod3"),
                       foreach::foreach (i = 1:num.per, .combine=rbind)),
        {
            out3 <- replicate(num.day,
                              do.call(fun2,
                                      c(list(fun31.params=fun31.params,
                                             fun32.params=fun32.params),
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
#' @param fun32on turn this copy of fun3 on or off
#' @export fun2

fun2 <- function (fun31.params, fun32.params, var21=0.5, var22=5, fun32on = TRUE, ...) {
    out21 <- ifelse (rpois(1, var21) > 0, var22 * do.call(fun3, fun31.params), 0)
    out22 <- ifelse (fun32on, do.call(fun3, fun32.params), 0 )
    out2 <- out21 + out22
}

#' Test function level 3
#' @param var31 first variable for function 3
#' @param fun3on turn the formula on or off
#' @export fun3

fun3 <- function (fun3on, var31, ...) {
    out3 <- ifelse (fun3on, var31, 1)
}

