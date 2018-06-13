library(testthat)
library(dieroller)

context("Check die functions")

test_that("check_sides with ok vectors", {

  expect_true(check_sides(1:6))
  expect_true(check_sides(c('i', 'ii', 'iii', 'iv', 'v', 'vi')))
})


test_that("check_sides fails with invalid lengths", {

  expect_error(check_sides(c('a', 'b', 'c', 'd', 'e')))
})


test_that("check_prob works with ok vectors", {

  expect_true(check_prob(rep(1/6,6)))
  expect_true(check_prob(c(0.2, 0.1, 0.1, 0.1, 0.5, 0.0)))
})


test_that("check_prob fails with invalid lengths", {

  expect_error(check_prob(c(0.075, 0.1, 0.125, 0.15, 0.20)))
})


test_that("check_prob fails with invalid numbers", {

  expect_error(check_prob(c(0.075, 0.1, 0.125, 0.15, 0.20, 'A')))
  expect_error(check_prob(c(0.075, 0.1, 0.125, 0.15, 0.20, NA)))
})

test_that("check_prob fails with invalid sum", {

    expect_error(check_prob(c(0.075, 0.1, 0.125, 0.15, 0.20, 0)))
    expect_error(check_prob(c(0.075, 0.1, 0.125, 0.15, 0.20, 0.7)))
  })








