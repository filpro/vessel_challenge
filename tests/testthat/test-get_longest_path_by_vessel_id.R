setwd("../..")

test_that("getLongestPathByVesselId selects the most recent observation if there are equal max dists", {
  # We are stubing function so that we can use artificial object
  object = tibble(
    row = c(1,2,3),
    dist = c(3,3,3), # three same distances
    TIME_DIFF = c(4,3,2),
    DATETIME = c(Sys.time(), Sys.time() + 20, Sys.time() + 10)
  )
  
  stub(getLongestPathByVesselId, 'memo$getVesselById',object)
  result = getLongestPathByVesselId(3636)
  
  expect_equal(result$row, 2, label = "We expect the second one to be chosen as the most recent one")
})

test_that("getLongestPathByVesselId returns longest path for time interval = NA", {
  id = 3636
  timeInterval = NA
  result = getLongestPathByVesselId(id, timeInterval)
  expect_equal(result$ROW_NO_LAG, 2053695)
  expect_equal(result$ROW_NO, 2053696)
})

test_that("getLongestPathByVesselId adjust result according to the time interval", {
  id = 4342553
  timeInterval = 8 * 60 * 60 # seconds to hours
  result1 = getLongestPathByVesselId(id, timeInterval)
  expect_equal(result1$ROW_NO_LAG, 1712848)
  expect_equal(result1$ROW_NO, 1712849)
  
  timeInterval = 14 * 60 * 60 # seconds to hours
  result2 = getLongestPathByVesselId(id, timeInterval)
  expect_equal(result2$ROW_NO_LAG, 1712842)
  expect_equal(result2$ROW_NO, 1712843)
  
  expect_gte(result2$dist,result1$dist) # If result1 was greater then would be equal to result2
})


test_that("getLongestPathByVesselId removes limit for timeInterval equal NA or 0", {
  id = 4342553
  timeInterval = NA
  result1 = getLongestPathByVesselId(id, timeInterval)
  
  timeInterval = 0
  result2 = getLongestPathByVesselId(id, timeInterval)
  
  maxDist = getVesselById(id)$dist %>% max()
  
  expect_equal(maxDist, result1$dist)
  expect_equal(maxDist, result2$dist)
})

