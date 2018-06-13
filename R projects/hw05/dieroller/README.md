README
================
Ren Yi Wang
April 27, 2018

Overview
--------

`"dieroller"` is a minimal [R](http://www.r-project.org/) package that provides functions to simulate rolling a die.

-   `die()` creates a coin object (of class `"die"`)
-   `roll()` tosses a coin object, producing a `"roll"` object.
-   `plot()` method for a `"roll"` object to plot frequencies of heads.
-   `summary()` method for a `"roll"` object.

Motivation
----------

This package has been developed to illustrate some of the concepts behind the creation of an R package.

Installation
------------

Install the development version from GitHub via the package `"devtools"`:

``` r
# development version from GitHub:
#install.packages("devtools") 

# install "cointoss" (without vignettes)
devtools::install_github("gastonstat/cointoss")

# install "cointoss" (with vignettes)
devtools::install_github("gastonstat/cointoss", build_vignettes = TRUE)
```

Usage
-----

``` r
library(dieroller)

# default die
fair_die <- die()
fair_die
#> object "die" 
#> 
#>   sides      prob stringAsFactors
#> 1     1 0.1666667           FALSE
#> 2     2 0.1666667           FALSE
#> 3     3 0.1666667           FALSE
#> 4     4 0.1666667           FALSE
#> 5     5 0.1666667           FALSE
#> 6     6 0.1666667           FALSE

# 1 roll of fair_die
roll(fair_die, 1)
#> object "roll" 
#> 
#> $rolls 
#> [1] 1

# 10 rolls of fair_die
roll10 <- roll(fair_die, times = 10)
roll10
#> object "roll" 
#> 
#> $rolls 
#>  [1] 4 2 1 2 2 1 5 6 3 3

# summary
summary(roll10)
#> summary "roll" 
#> 
#>   side count prop
#> 1    1     2  0.2
#> 2    2     3  0.3
#> 3    3     2  0.2
#> 4    4     1  0.1
#> 5    5     1  0.1
#> 6    6     1  0.1


# 100 rolls
roll100 <- roll(fair_die, times = 100)

# summary
summary(roll100)
#> summary "roll" 
#> 
#>   side count prop
#> 1    1    15 0.15
#> 2    2    17 0.17
#> 3    3    13 0.13
#> 4    4    17 0.17
#> 5    5    15 0.15
#> 6    6    23 0.23
```
