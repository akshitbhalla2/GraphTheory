#install.packages("tidyverse", "maps", "geosphere")
library("tidyverse")
library("maps")
library("geosphere")

#Defining map
par(mar = c(0, 0, 0, 0))
map(
  "world",
  fill = TRUE,
  col = "white",
  bg = "lightblue",
  ylim = c(-60, 90),
  mar = c(0, 0, 0, 0)
)

#Defining coordinates
berlin = c(13.39, 52.5)
london = c(-0.12, 51.5)
dubai = c(55.29, 25.26)
mumbai = c(72.83, 18.96)
sydney = c(151.21, -33.86)
melbourne = c(144.96, -37.81)
rio = c(-43.2, -22.91)

#Preparing table of coordinates
data = rbind(berlin, london, dubai, mumbai, sydney, melbourne, rio) %>% as.data.frame()
colnames(data) = c("long", "lat")

#Making location points red
points(
  x = data$long,
  y = data$lat,
  col = "red",
  cex = 3,
  pch = 20
)

#Connecting Berlin and London
inter <-
  gcIntermediate(
    berlin,
    london,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "green", lwd = 2)

#Connecting Berlin and Rio
inter <-
  gcIntermediate(
    berlin,
    rio,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "darkgoldenrod", lwd = 2)

#Connecting London and Sydney
inter <-
  gcIntermediate(
    london,
    sydney,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "deeppink", lwd = 2)

#Connecting Dubai and Mumbai
inter <-
  gcIntermediate(
    dubai,
    mumbai,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "lightcoral", lwd = 2)

#Connecting Dubai and Sydney
inter <-
  gcIntermediate(
    dubai,
    sydney,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "navy", lwd = 2)

#Connecting Mumbai and Melbourne
inter <-
  gcIntermediate(
    mumbai,
    melbourne,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "yellow", lwd = 2)

#Connecting Melbourne and Rio
inter <-
  gcIntermediate(
    melbourne,
    rio,
    n = 50,
    addStartEnd = TRUE,
    breakAtDateLine = FALSE
  )
lines(inter, col = "orange", lwd = 2)