#' @title check_sides
#' @description check if sides is valid
#' @param sides vector of die sides
#' @return TRUE if the vector sides is valid
check_sides <- function(sides) {
  if (length(sides) != 6) {
    stop('\n sides must be of length 6')
  }
  return(TRUE)
}

#' @title check_prob
#' @description check if prob is valid
#' @param prob vector of probability
#' @return TRUE if the probability is valid
check_prob <- function(prob) {
  if (length(prob) != 6 | is.numeric(prob) == FALSE) {
    stop('\n prob must be a numeric vector of length 6')
  }

  if (any(prob < 0) | any(prob > 1)) {
    stop('\n prob must be between 0 and 1, inclusive')
  }

  if (sum(prob) != 1) {
    stop('\n elements in prob must add up to 1')
  }

  return(TRUE)
}

#' @title die
#' @description construct a die class
#' @param sides vector of die sides
#' @param prob vector of die probability
#' @return an object with class 'die'
die <- function(sides = 1:6, prob = rep(1/6, 6)) {
  check_sides(sides)
  check_prob(prob)

  object = list('sides' = sides, 'prob' = prob)
  class(object) <- 'die'

  return(object)
}

#' @title print.die
#' @description print the object with class 'die'
#' @param object an object with class 'die'
#' @return display the die's sides as well as its probabilities
print.die <- function(object) {
  object <- data.frame('sides' = object$sides,
                       'prob' = object$prob,
                       stringAsFactors = FALSE)
  cat('object "die"', '\n\n')
  print(object)
  invisible(object)
}
