#' @title init_sinew
#' @description FUNCTION_DESCRIPTION
#' @param add_fields PARAM_DESCRIPTION, Default: c("details", "examples", "rdname", "export", "author")
#' @param author PARAM_DESCRIPTION, Default: as.character(person("Lorenzo", "Busetto, phD (2017)", email = "lbusett@gmail.com"))
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
#' @importFrom sinew sinew_opts
#'
init_sinew <- function(add_fields = c("details", "examples", "rdname", "export", "author"),
                       author = as.character(person("Lorenzo", "Busetto, phD (2017)", email = "lbusett@gmail.com"))) {
  if (requireNamespace("sinew")) {
  sinew::sinew_opts$set(add_fields = add_fields)
  sinew::sinew_opts$set(author     = author)
  message("current add_fields: ", paste(sinew_opts$get("add_fields"), collapse = " "))
  message("current author: ", sinew_opts$get("author"))
  }
}
