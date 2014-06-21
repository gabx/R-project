
# function to create a matrix, set/get its value and set/get its inverse 
# with the solve() function. 
# We assume the matrix is inversible

makeCacheMatrix <- function(x = matrix()) {
    
    # create a new env with empty parent. This avoid inherit unwanted objects
    my_env <- new.env(parent = emptyenv())
    # store m variable in my_env & bind it to NULL
    my_env$m <- NULL
    
    get <- function() x
 

}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}
