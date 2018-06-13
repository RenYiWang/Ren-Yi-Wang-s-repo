library(testthat)
library(dieroller)

context('check roll functions')

test_that('check_times with ok vectors', {

  expect_true(check_times(500))
  expect_true(check_times(1))
})

test_that('check_sides fails with invalid type', {

  expect_error(check_times(c('a','b','c')))
  expect_error(check_times(-500))
  expect_error(check_times(3.1415926))
})
