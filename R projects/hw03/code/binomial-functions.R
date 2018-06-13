#' @title is_integer
#' @description test if input is of type integer
#' @param x user provided number
#' @return TRUE or FALSE
is_integer <- function(x) {
  if (x %% 1 == 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

#' @title is_positive 
#' @description test if input is positive or not
#' @param x user provided number
#' @return TRUE or FALSE
is_positive <- function(x) {
  if (x > 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

#' @title is_nonnegative
#' @description test if input is nonnegative
#' @param x user provided number
#' @return TRUE or FALSE
is_nonnegative <- function(x) {
  if (x >= 0) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

#' @title is_positive_integer 
#' @description test if the input is a positive integer
#' @param inputs x
#' @return TRUE or FALSE
is_positive_integer <- function(x) {
  if (is_integer(x) & (is_positive(x))) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

#' @title is_nonneg_integer
#' @description test if the input is a nonnegative integer
#' @param x user provided input
#' @return TRUE or FALSE
is_nonneg_integer <- function(x) {
  if (is_integer(x) & (is_nonnegative(x))) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

#' @title is_probability
#' @description test if the input is a probability
#' @param p user provided probability value
#' @return TRUE or FALSE
is_probability <- function(p) {
  if (p >=0 & p <= 1) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

#' @title bin_factorial
#' @description calculate factorial
#' @param x user provided integer
#' @return input factorial
bin_factorial <- function(x) {
  if (x == 0) {
    return(1)
  }
  else {
    total = 1
    for (i in 1:x) {
      total = total * i
    }
    return(total)
  }
}

#' @title bin_combinations
#' @description calculate binomial combination
#' @param n,k user provided input to calculate binomial
#' @return n choose k
bin_combinations <- function(n, k) {
  return(bin_factorial(n)/(((bin_factorial(k)) * (bin_factorial(n-k)))))
}

#' @title bin_probability
#' @description find binomial probability
#' @param trials,success,prob user provided input
#' @return binomial probability of input
bin_probability <- function(trials, success, prob) {
  if (is_nonneg_integer(trials) & is_nonneg_integer(success) & is_probability(prob)) {
    return((bin_combinations(trials, success)) * (prob^success) * (1-prob)^(trials-success)) 
  }
  else {
    stop("Wrong inputs")
  }
}

#' @title bin_distribution
#' @description find binomial probability distribution
#' @param trials,prob user provided trials and probability
#' @return a data frame representing the probability distribution 
bin_distribution <- function(trials, prob) {
  success = c(0:trials)
  prob_vec = rep(0, trials+1)
  for (i in 0:trials) {
    prob_vec[i+1] = bin_probability(trials, i, prob)
  }
  df <- data.frame("success" = success, "probability" = prob_vec)
  return(df)
}

