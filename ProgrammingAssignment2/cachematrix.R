
# function to set/get the value of a matrix and set/get its inverse 
# with the solve() function, as a list of functions.
# We will assume the matrix is inversible (i.e nrow=ncol)
# This kind of functions are called "constructor".

makeCacheMatrix <- function(x = matrix()) {
    
    # create a new env with empty parent. This avoid inherit unwanted objects
    my_env <- new.env(parent = emptyenv())
    # store variable s in my_env & bind it to NULL
    my_env$s <- NULL

    
    set <- function(y){
        # this fun assign y to x & NULL to s
        x <<- y
        s <<- NULL 
    }
    
    # return x
    get <- function() x
    
    setsolve <- function(solve) s <<- solve
    
    # return y, inverse of x
    getsolve <- function() i
 
    list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)

}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}
