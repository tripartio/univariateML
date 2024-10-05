#' zzz.R
#' Code to run after all other package files have been loaded.

# Set attributes of all ml***() functions -----------

# Set attributes of an ml***() function
set_ml_fun_attr <- function(
    ml_fun,  # the literal function (not a character string, e.g., mlnorm, mlpois, etc.)
    x = 0.9    # a dummy vector to use to create a temporary univariateML object
) {
  # Create a temporary univariateML object so that we can get the standard object
  # attributes for this ml* object type.
  ml_obj <- ml_fun(x)

  # Copy the attributes that are relevant not just to an object but to the function itself
  attr(ml_fun, "params") <- attr(ml_obj, "names")
  attr(ml_fun, "model") <- attr(ml_obj, "model")
  attr(ml_fun, "density") <- attr(ml_obj, "density")
  attr(ml_fun, "support") <- attr(ml_obj, "support")

  ml_fun
}

# densities is the character vector of ml*** function names from densities.R
for (ml_fun in densities) {
  assign(
    ml_fun,
    set_ml_fun_attr(get(ml_fun))  # get() needed because ml_fun here is a string
  )
}

# devtools::load_all(".")
# mlpois
# attributes(mlpois)
# mlpois <- set_ml_fun_attr(mlpois)
# attributes(mlpois)


