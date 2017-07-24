init_sinew <- function() {
  sinew_opts$set(add_fields = c("details", "examples", "rdname", "export", "author"))
  sinew_opts$set(author    = as.character(person("Lorenzo", "Busetto, phD (2017)", email = "lbusett@gmail.com")))
  message("current add_fields: ", sinew_opts$get("add_fields"))
  message("current author: ", sinew_opts$get("author"))
}
