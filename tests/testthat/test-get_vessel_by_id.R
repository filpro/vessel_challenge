setwd("../..")

test_that("Get vessel by id returns correct values", {
  id = 3636
  result = getVesselById(id)
  
  expect_equal(id, result$SHIP_ID %>% unique())
})


test_that("Get vessel by id returns null when id = NA", {
  id = NA
  expect_null(getVesselById(id))
})

test_that("Get vessel by id returns null when id not found", {
  id = 9999999999
  expect_null(getVesselById(id))
})
