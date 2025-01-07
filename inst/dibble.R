
## MAKE INTO DIBBLE OBJECT
#install.packages("S7")
#library(S7)

# class is dibble, method is changed ggplot functions, generic.class
# check class with typeof() and class()
# ftype(ggplot) = generic
# ftype(ggplot.sf) = method

# S3 Practice
# method 1
#x <- structure(list(), class = "my_class")

# method 2
#x <- list()
#class(x) <- "my_class"

# so can just do
#class(toymap) <- "dibble"
# inherits(object, class) tells you if an object belongs to a class
# If m is a tibble
# inherits(m, "tbl") =true because table in list
# inherits(m, "data.frame") =true becase data.frame in list
# inherits(m, "dibble") #=false becase dibble not in list

# Should probide three functions
# 1) Constructor new_myclass(), that efficiently creates new objects with the correct structure.
# 2) Validator, validate_myclass(), that performs more computationally expensive checks to ensure that the object has correct values.
# 3) Helper, myclass(), that provides a convenient way for others to create objects of your class.

# new_dibble() : creates new object with correct structure (?) idk how that is different from (3)
# validate_dibble() : checks that the dibble has correct values
# dibble() : allows people to make a dibble object
# as_dibble -> should also be one so you can concert an existing tibble


# constructor 3 principles
# 1) be called new_dibble()
# 2) have one argument for the base object and one for each attribute
# 3) Check the type of the base object and the types of each attribute


# base object is list?? (or tibble or data frame?)

#new_dibble <- function(x = list() ) {
#  structure(x,class = "dibble")
#}

# format from tsibble
new_dibble <- function (x, ..., class = NULL) {
  #not_dibble(x)
  x <- new_tibble(x, ..., nrow = vec_size(x), class = "dibble")
  assert_key_data(attr(x, "key"))
  class(x) <- c(class, class(x))
  x
}

validate_dibble <- function(x) {
  cls <- class(x)
  if (cls !== "dibble")) {
    stop(
      "something something something",
      call. = FALSE
    )
  }
  x
}

new_factor(1:5, "a")
#> Error in as.character.factor(x): malformed factor
new_factor(0:1, "a")
#> Error in as.character.factor(x): malformed factor


