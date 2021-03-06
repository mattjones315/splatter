context("SplatParams")

params <- newSplatParams()

test_that("printing works", {
    expect_output(show(params), "A Params object of class SplatParams")
})

test_that("nBatches checks work", {
  expect_error(setParam(params, "nCells", 1),
               "nCells cannot be set directly, set batchCells instead")
  expect_error(setParam(params, "nBatches", 1),
               "nBatches cannot be set directly, set batchCells instead")
})

test_that("nGroups checks work", {
    expect_error(setParam(params, "nGroups", 1),
                 "nGroups cannot be set directly, set group.prob instead")
})

test_that("path.from checks work", {
    pp <- setParams(params, group.prob = c(0.5, 0.5))
    pp <- setParamUnchecked(pp, "path.from", c(0, 1))
    expect_silent(validObject(pp))
    pp <- setParamUnchecked(pp, "path.from", c(0, 3))
    expect_error(validObject(pp), "invalid class")
    pp <- setParamUnchecked(pp, "path.from", c(1, 0))
    expect_error(validObject(pp), "path cannot begin at itself")
    pp <- newSplatParams()
    pp <- setParams(pp, group.prob = c(0.3, 0.3, 0.4))
    pp <- setParamUnchecked(pp, "path.from", c(2, 1, 1))
    expect_error(validObject(pp), "origin must be specified in path.from")
})
