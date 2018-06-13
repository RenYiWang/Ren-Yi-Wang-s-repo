# ===================================================================
# Title: Regex Functions
# Description: Functions operating on strings
# Input(s): 
# Output(s): 
# Author(s): Ren Yi Wang
# Date: 04-13-2018
# ===================================================================

# 2.1) Splitting Characters

#' @title split_chars
#' @description splitting character
#' @param x user provided string
#' @return a vector of splitted characters
split_chars <- function(x){
  return(unlist(str_split(x,pattern = '')))
}

# Tesi
split_chars('Go Bears!')
split_chars('Expecto Patronum')

# 2.2) Number of Vowels

#' @title num_vowels
#' @description count the number of vowels in a character vectors
#' @param x user provided character vector
#' @return number of vowels in vector
num_vowels <- function(x){
  
  a_num <- sum(str_detect(split_chars(x), pattern = 'a|A'))
  e_num <- sum(str_detect(split_chars(x), pattern = 'e|E'))
  i_num <- sum(str_detect(split_chars(x), pattern = 'i|I'))
  o_num <- sum(str_detect(split_chars(x), pattern = 'o|O'))
  u_num <- sum(str_detect(split_chars(x), pattern = 'u|U'))
  vowels <- c(a = a_num, e = e_num, i = i_num, o = o_num, u = u_num)
  
  return(vowels)
}

# Test
vec <- c('G', 'o', ' ', 'B', 'e', 'a', 'r', 's', '!')
num_vowels(vec)

#  2.3) Counting Vowels

#' @title count_vowels
#' @description count number of vowels in a string
#' @param x user provided string
#' @return number of each voewls in the string in vector
count_vowels <- function(x){
  words_vec <- unlist(str_split(x,pattern = ' '))
  letters_vec <- split_chars(words_vec)
  
  return(num_vowels(letters_vec))
}

# Test
count_vowels("The quick brown fox jumps over the lazy dog")
count_vowels("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")

# 2.4) Reversing Characters

#' @title reverse_chars
#' @description reverse strings
#' @param x user provided string
#' @return reversed string
reverse_chars <- function(x) {
  rev <- paste(rev(split_chars(x)), collapse = '')
  return(rev)
}

# Test
reverse_chars("gattaca")
reverse_chars("Lumox Maxima")

# 2.5) Reversing Sentences by Words

#' @title reverse_wrods
#' @description reverse sentences by words
#' @param x user provided string
#' @return reversed sentences
reverse_words <- function(x){
  words_vec <- unlist(lapply(x, str_split, ' '))
  rev_vec <- rep(' ', length(words_vec))
  
  for(i in 1:length(words_vec)){
    rev_vec[i] = words_vec[length(words_vec)-i+1]
  }
  rev_string <- paste(rev_vec, collapse = ' ')
  return(rev_string)
}

# Test
reverse_words("sentence! this reverse")
reverse_words("string")