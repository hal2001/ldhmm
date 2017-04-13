#' Computing the log forward and backward probabilities
#' 
#' This utility computes the logarithms of the forward and backward probabilities, 
#' aka alpha and beta. 
#' The logarithm keeps the computation away from floating point under/over-flow. 
#' (Zucchini, 5.4)
#'
#' @param object an ldhmm object
#' @param x numeric, the observations.
#'
#' @return numeric, the log probabilities
#'
#' @keywords pdf
#'
#' @author Stephen H. Lihn
#'
#' @export ldhmm.log_forward
#' @export ldhmm.log_backward
#' 
### <======================================================================>
ldhmm.log_forward <- function(object, x)
{
    m <- object@m
    n <- length(x)
    pdf <- ldhmm.state_pdf(object, 1:m, x)
    
    log_alpha <- matrix(NA, m, n)
    phi <- object@delta * pdf[,1]
    sum_phi <- sum(phi)
    log_phi_scale <- log(sum_phi)
    phi <- phi/sum_phi
    log_alpha[,1] <- log_phi_scale + log(phi) # record log alpha
    for (i in 2:n) {
        phi <- phi %*% object@gamma * pdf[,i]
        sum_phi <- sum(phi)
        log_phi_scale <- log_phi_scale + log(sum_phi)
        phi <- phi/sum_phi
        log_alpha[,i] <- log_phi_scale + log(phi) # record log alpha
    }
    return(log_alpha)
}
### <---------------------------------------------------------------------->
#' @rdname ldhmm.log_forward
ldhmm.log_backward <- function(object, x)
{
    m <- object@m
    n <- length(x)
    pdf <- ldhmm.state_pdf(object, 1:m, x)
    
    log_beta <- matrix(NA, m, n)
    log_beta[,n] <- rep(0, m) # record log beta
    phi <- rep(1/m, m)
    log_phi_scale <- log(m)
    for (i in (n-1):1)
    {
        phi <- object@gamma %*% (pdf[,i+1] * phi)
        log_beta[,i] <- log(phi)+log_phi_scale # record log beta
        sum_phi <- sum(phi)
        log_phi_scale <- log_phi_scale + log(sum_phi)
        phi <- phi/sum_phi
    }
    return(log_beta)
}
### <---------------------------------------------------------------------->