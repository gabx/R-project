
# function to set/get the value of a matrix and set/get its inverse 
# with the solve() function, as a list of functions.
# This kind of functions are called "constructor".

makeCacheMatrix <- function(x = matrix()) {
    
    # assign NULL to s
    s <- NULL
    
    set <- function(y){
        # this fun assign y to x & NULL to s
        # NB: the use of <<- . This operator is used in functions & cause a 
        # search through parent environments for an existing definition.
        x <<- y
        s <<- NULL 
    }
    
    # return x
    get <- function() x
    
    set.solve <- function(solve) s <<- solve
    
    # return y, inverse of x
    get.solve <- function() s
 
    # return our list of functions
    list(set = set, get = get, set.solve = set.solve, get.solve = get.solve)

}


# function to calculate the inverse of the matrix created with makeCacheMatrix().
# This fun will first test if inverse has already being calculated and if true
# will reuse inverse from cache.
# We will assume the matrix is inversible (i.e nrow=ncol)
cacheSolve <- function(x, ...) {

    
    s <- x$get.solve()
    
    # test if i already computed and shout message
    if(!is.null(s)) {
    message("inverse has already be calclated\n", "getting result from cache")
        return(s)          
    }
    
    # Case result not already computed
    
    # get matrix
    mat <- x$get()
    
    # inverse the matrix
    s <- solve(mat, ...)
    
    # set result
    x$set.solve(s)
    s
}
