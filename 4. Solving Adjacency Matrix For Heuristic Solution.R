#Heuristic Solution to the Traveling Salesman Problem

m <- 1
temp <- MyMatrix
loop <- size
rtrack <- array(c(1:loop))
ctrack <- array(c(1:loop))
single_tour <- matrix(nrow = size, ncol = 2)
tour <- matrix(nrow = size, ncol = 2)

for (t in 1:loop) {
  #Row Minimization
  for (i in 1:loop) {
    minimum <- temp[i, which.min(temp[i,])]
    temp[i, ] <- temp[i, ] - minimum
  }
  
  #Column Minimization
  for (j in 1:loop) {
    minimum <- temp[which.min(temp[, j]), j]
    temp[, j] <- temp[, j] - minimum
  }
  
  #Matrix of Dij
  n <- 0
  for (i in 1:loop) {
    for (j in 1:loop) {
      if (temp[i, j] == 0) {
        n <- n + 1
      }
    }
  }
  Dij <- matrix(nrow = n, ncol = 3)
  l <- 1
  for (i in 1:loop) {
    for (j in 1:loop) {
      if (temp[i, j] == 0) {
        row <- temp[i, ]
        col <- temp[, j]
        row <- row[-j]
        col <- col[-i]
        r <- row[which.min(row)]
        c <- col[which.min(col)]
        Dij[l, 1] <- r + c
        Dij[l, 2] <- i
        Dij[l, 3] <- j
        l <- l + 1
      }
    }
  }
  
  #Finding Highest Dij
  a <- Dij[which.max(Dij[, 1]), 2]
  b <- Dij[which.max(Dij[, 1]), 3]
  
  #Assigning Infinity
  if ((rtrack[b] %in% ctrack[-a]) && (ctrack[a] %in% rtrack[-b])) {
    temp[match(rtrack[b], ctrack), match(ctrack[a], rtrack)] <- Inf
  }
  
  #Tour (not in order)
  single_tour[m, 1] <- ctrack[a]
  single_tour[m, 2] <- rtrack[b]
  m <- m + 1
  rtrack <- rtrack[-b]
  ctrack <- ctrack[-a]
  
  #Removing Row and Column
  temp <- temp[-a,-b]
  loop <- loop - 1
  if (loop == 1) {
    single_tour[m, 1] <- ctrack[1]
    single_tour[m, 2] <- rtrack[1]
    break
  }
}

#Tour (in order)
for (i in 1:size) {
  if (single_tour[i, 1] == 1) {
    tour[1, 1] <- single_tour[i, 1]
    tour[1, 2] <- single_tour[i, 2]
  }
}
for (i in 1:(size - 1)) {
  for (j in 1:size) {
    if (single_tour[j, 1] == tour[i, 2]) {
      tour[i + 1, 1] <- single_tour[j, 1]
      tour[i + 1, 2] <- single_tour[j, 2]
    }
  }
}
my.tour.graph <- graph(t(tour), directed = FALSE)
plot(my.tour.graph)
distance <- 0
for (i in 1:size) {
  distance <-
    distance + MyMatrix[single_tour[i, 1], single_tour[i, 2]]
}

#Total Distance
printf <- function(...)
  invisible(print(sprintf(...)))
printf("Distance : %d", distance)