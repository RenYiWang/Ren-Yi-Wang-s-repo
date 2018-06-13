# ===================================================================
# Title: Archive of an R Package
# Description: Functions for reading, cleaning, and plotting R packages
# Input(s): data in CRAN webpage
# Output(s): 
# Author(s): Ren Yi Wang
# Date: 04-13-2018
# ===================================================================
library(XML)
library(stringr)
library(ggplot2)

## 1.1) Read Archive Data Table

#' @title read_archive
#' @description read html
#' @param x user provided string
#' @return a data frame about R packages
read_archive <- function(x) {
  url <- paste('http://cran.r-project.org/src/contrib/Archive/', x, sep = '')
  html_table <- readHTMLTable(url)
  html_df <- as.data.frame(html_table[[1]])
  return(html_df)
}

# Test case
raw_data <- read_archive('stringr')
raw_data

## 1.2) Data Cleaning

#' @title clean_archive
#' @description clean data frame
#' @param x data frame returned by read_archive
#' @return a clean data frame about R packages
clean_archive <- function(x){
  name <- version_names(x)
  number<- version_number(x)
  date <- version_date(x)
  size <- version_size(x)
  df <- data.frame('name' = name,
                   'version' = number,
                   'date' = date,
                   'size' = size,
                   stringsAsFactors = FALSE)
  return(df)
}

#' @title version_names
#' @description extract version names
#' @param x data frame returned by read_archive
#' @return version name of a package
version_names <- function(x){
  name_version <- str_replace(x$Name, pattern = ".tar.gz", replacement = "")
  name_version <- str_split(name_version,pattern = "_")
  name_version <- lapply(name_version, function(x) x[1])
  name_version <- unlist(name_version)
  return(name_version[3:(length(name_version)-1)])
}

#' @title version_number
#' @description extract version number
#' @param x data frame returned by read_archive
#' @return version number of a package
version_number <- function(x){
  name_version <- str_replace(x$Name, pattern = ".tar.gz", replacement = "")
  name_version <- str_split(name_version,pattern = "_")
  name_version <- lapply(name_version, function(x) x[2])
  name_version <- unlist(name_version)
  return(name_version[3:(length(name_version)-1)])
}

#' @title version_date
#' @description extract version date
#' @param x data frame returned by read_archive
#' @return version date of a package
version_date <- function(x){
  date_version <- x$"Last modified"
  date_version <- str_sub(date_version,end = -6) 
  return(date_version[3:(length(date_version)-1)])
}

#' @title version_size
#' @description extract version size
#' @param x data frame returned by read_archive
#' @return version size of a package
version_size <- function(x){
  size_val <- str_sub(x$Size,end = -2)
  size_val <- size_val[3:(length(size_val)-1)]
  
  unit<- str_sub(x$Size,start = -1)
  unit <- unit[3:(length(unit)-1)]

  for (i in 1:length(unit)) {
    if(unit[i] == 'M')
      size_val[i] <- as.numeric(size_val[i]) *1000
  }
  return(size_val)
}

# Test case
clean_data <- clean_archive(raw_data)
clean_data

## 1.3) Timeline plot

#' @title plot_archive
#' @description visualize the timeline with the version sizes of a package
#' @param x data frame returned by clean_archive
#' @return a plot about R package
plot_archive<-function(x){
  years <- vector(mode = "numeric")
  
  for (i in 1:length(x$date)) {
    time <- as.numeric(str_split(x$date,pattern = "-")[[i]])
    years[i] <- time[1] + time[2]/12 + time[3]/365 
  }
  
  ggplot(x,aes(x = years, y = as.numeric(x$size))) +
    geom_point(color = "blue") +
    geom_step(color = "#9999CC") + 
    xlab('date') +
    ylab('Size(Kilobytes)')
}

# step line chart
plot_archive(clean_data)

