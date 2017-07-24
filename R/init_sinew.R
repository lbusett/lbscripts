#' @title Initialize SINEW opts for roxygenize
#' @description FUNCTION_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname init_sinew
#' @export
#' @author Lorenzo Busetto, phD (2017) <lbusett@gmail.com>
init_sinew <- function() {
  sinew_opts$set(add_fields = c("details", "examples", "rdname", "export", "author"))
  sinew_opts$set(author    = as.character(person("Lorenzo", "Busetto, phD (2017)", email = "lbusett@gmail.com")))
  message("current add_fields: ", sinew_opts$get("add_fields"))
  message("current author: ", sinew_opts$get("author"))
}
