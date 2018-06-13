#' @title check_times
#' @description check if times is valid
#' @param times number of times that a die is rolled
#' @return TRUE if the number times is valid
check_times <- function(times) {
  if (times%%1 != 0 | times <= 0)
    stop('\n times must be a positive integer')
  return(TRUE)
}

#' @title roll
#' @description roll a die several times
#' @param die an object that has class 'die'
#' @param times number of times that a die is rolled
#' @return a list that has information about the outcome of roll
roll <- function(x, ...) UseMethod("roll")
roll.die <- function(die, times = 1) {
  check_times(times)
  rolls <- sample(die$sides, size = times, replace = TRUE, prob = die$prob)
  rolls <- list('rolls' = rolls,
                'sides' = die$sides,
                'prob' = die$prob,
                'total' = times)
  class(rolls) <- 'roll'
  return(rolls)
}

#' @title print.roll
#' @description print the roll object
#' @param rolls an object with class 'roll'
#' @return a table about the roll object
print.roll <- function(rolls) {
  rolls <- data.frame('rolls' = rolls$rolls, stringsAsFactors = FALSE)
  cat('object "roll"', '\n\n')
  cat('$rolls', '\n')
  print(rolls$rolls)
  invisible(rolls)
}

#' @title summary.roll
#' @description summarize the roll object
#' @param rolls an object with class 'roll'
#' @return a summary about the roll object
summary.roll <- function(rolls) {
  roll_table_df <- data.frame(table(rolls$rolls), stringsAsFactors = FALSE)
  roll_count <- roll_table_df$Freq
  roll_prop <- roll_count/rolls$total
  roll_df <- data.frame('freqs' = c(as.character(rolls$sides),
                                    as.character(roll_count),
                                    as.character(roll_prop)),
                        stringsAsFactors = FALSE)
  class(roll_df) <- 'summary.roll'
  return(roll_df)
}

#' @title print.summary.roll
#' @description print the summary of rolls
#' @param df an object with class 'summary.roll'
#' @return a summary about the summary.roll object
print.summary.roll <- function(df) {
  df_len <- length(df$freqs)
  df <- data.frame('side' = df$freqs[1:(df_len/3)],
                   'count' = df$freqs[((df_len/3)+1):((2*df_len)/3)],
                   'prop'= df$freqs[((2*df_len/3)+1):df_len])
  cat('summary "roll"', '\n\n')
  print(df)
  invisible(df)
}

#' @title plot.roll
#' @description plot the object roll
#' @param rolls an object of class 'roll'
#' @return a plot about the roll object
plot.roll <- function(rolls) {
  barplot(table(rolls$rolls)/rolls$total, xlab = 'side of die', ylab = 'relative frequencies', border = NA)
}

#' @title exract roll
#' @description extract the ith roll
#' @param i the roll number that is extracted
#' @return the ith roll
'[.roll' <- function(rolls, i) {
  return(rolls$rolls[i])
}

#' @title replace roll
#' @description replace a specific roll
#' @param rolls an object of class 'roll'
#' @param i the index of roll that will be replaced
#' @param value the value that will replace the ith entry in the roll
#' @return a new roll with ith entry replaced by value
'[<-.roll' <- function(rolls, i, value) {
  if (i < 1 | i > rolls$total) {
    stop('\n index out of bounds')
  }

  if (value %in% rolls$sides == FALSE) {
    stop('\n invalid replacing value')
  }

  rolls$rolls[i] <- value
  new_rolls <- list('rolls' = rolls$rolls,
                    'sides' = rolls$sides,
                    'prob' = rolls$prob,
                    'total' = rolls$total)
  class(new_rolls) <- 'roll'
  return(new_rolls)
}

#' @title add roll
#' @description add some rolls
#' @param rolls an object of class 'roll'
#' @param increment the number of additional rolls
#' @return a new roll with new rolls included
'+.roll' <- function(rolls, increment) {
  if (length(increment) != 1 | increment <= 0 | increment%%1 != 0) {
    stop('\n increment must be a positive integer')
  }

  origin_sides <- rolls$sides
  origin_rolls <- rolls$rolls
  origin_prob <- rolls$prob
  origin_total <- rolls$total

  origin_die <- list('sides' = origin_sides, 'prob' = origin_prob)
  class(origin_die) <- 'die'

  add_rolls <- roll(origin_die, times = increment)

  new_rolls <- list('rolls' = c(origin_rolls, add_rolls$rolls),
                    'sides' = rolls$sides,
                    'prob' = rolls$prob,
                    'total' = origin_total + increment)
  class(new_rolls) <- 'roll'
  return(new_rolls)
}

