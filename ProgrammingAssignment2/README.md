### Assignment
This is programmingAssignment2 from coursera/prog-004.

Objective: write a functions able to cache a time-consuming computation. 
In this assignment, we compute the inverse of a matrix with the *solve()*
function.


First function, **makeCacheMatrix()**, is a constructor and returns a list of 
functions to set/get matrix value then set/get its inverse.

Second function, **cacheSolve()**, compute the inverse of a matrix IF result is
not already cached in. If cached, the function uses the already computed result.

All work has been done with [Rstudio IDE](http://www.rstudio.com/) using its 
integrated git functionnality.


### Test the functions

```{r}
mat <- rbind(c(1, -1/4), c(-1/4, 1))
my.matrix <- makeCacheMatrix(mat)
my.matrix$get()
      [,1]  [,2]
[1,]  1.00 -0.25
[2,] -0.25  1.00
cacheSolve(my.matrix)
               [,1]           [,2]
[1,] 1.066666666667 0.266666666667
[2,] 0.266666666667 1.066666666667
gabx@hortensia [R] cacheSolve(my.matrix)
inverse has already be calclated
getting result from cache
               [,1]           [,2]
[1,] 1.066666666667 0.266666666667
[2,] 0.266666666667 1.066666666667
```

