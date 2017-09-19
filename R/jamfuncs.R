#' Test function level 1
#' @param num.sim first variable for function 1
#' @param num.per second variable for function 1
#' @param num.day third variable for function 1
#' @param fun2.params parameters for function 2
#' @param fun31.params parameters for first call of function 3
#' @param fun32.params parameters for second call of funtion 3
#' @param fun4.params parameters for call to function 4
#' @export fun1
fun1 <- function (fun2.params, fun31.params, fun32.params, fun4.params,
                  num.sim=10, num.per=8, num.day=5, ...) {
    final.results <- data.frame (foreach::`%dopar%`(
        foreach::`%:%`(foreach::foreach(j = 1:num.sim,
                                        .combine = cbind,
                                        .packages= c("toymod4")),
                       foreach::foreach (i = 1:num.per,
                                         .packages = c("toymod4"),
                                         .combine=rbind)), {
            e1 <- new.env()
            e1 <- list2env(c(fun2.params, fun31.params, fun32.params,
                             fun4.params), e1)
            out3 <- replicate(num.day, fun2(e1, var21, var22, fun22on))
            out2 <- data.frame(mean(out3))
        }
    )
    )
    ## save outputs for subsequent analyses if required
    saveRDS(final.results, file = paste(num.day ,"_", num.per, "_", num.sim, "_",
                                        format(Sys.time(), "%d_%m_%Y"),
                                        ".rds", sep=""))
    return(final.results)
}

#' Test function level 2
#' @param var21 first variable for function 2
#' @param var22 second variable for function 2
#' @param fun22on turn this copy of fun3 on or off
#' @param env environment to get variables from 
#' @export fun2
fun2 <- function (env, var21, var22, fun22on, ...) {
    attach(env)
    out21 <- ifelse (rpois(1, var21) > 0, var22 * fun3(e1, fun3on, var31), 0)
    out22 <- ifelse (fun22on, fun3(e1, fun3on, var31), 0)
    out2 <- out21 + out22
    detach(env)
    out2
}

#' Test function level 3
#' @param var31 first variable for function 3
#' @param fun3on turn the formula on or off
#' @export fun3
fun3 <- function (env, fun3on, var31, ...) {
    attach(env)
    out31 <- ifelse (fun3on, var31, 1)
    out32 <- ifelse (fun3on, fun4(e1, fun4on, var41), 0)
    out3 <- out31 + out32
    detach(env)
    out3
}

#' Test function level 4
#' @param var41 first variable for function 4
#' @param fun4on turn the formula on or off
#' @export fun4
fun4 <- function (env, fun4on, var41, ...) {
    attach(env)
    out4 <- ifelse (fun4on, var41, 1)
    detach(env)
    out4
}
