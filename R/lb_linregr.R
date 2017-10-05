#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x_col PARAM_DESCRIPTION
#' @param y_col PARAM_DESCRIPTION
#' @param group_var PARAM_DESCRIPTION, Default: NULL
#' @param na.rm PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname lb_linregr
#' @export
#' @author Lorenzo Busetto, phD (2017) <lbusett@gmail.com>
#' @importFrom broom tidy glance
#' @importFrom seplyr group_by_se select_se
#' @importFrom tidyr spread
#'
lb_linregr <- function(data,
                       x_col,
                       y_col,
                       group_var = NULL,
                       na.rm     = TRUE) {


  names(data)[which(names(data) == x_col)] <- "x"
  names(data)[which(names(data) == y_col)] <- "y"

  coeffs <- data %>%
    seplyr::group_by_se(., group_var) %>%
    do(broom::tidy(lm(y ~ x, .))) %>%
    seplyr::select_se(., c(group_var, "term", "estimate")) %>%
    tidyr::spread(term, estimate)

  names(coeffs)[2:3] <- c("intercept", "slope")

  stats <- data %>%
    seplyr::group_by_se(group_var) %>%
    do(broom::glance(stats::lm(y ~ x, ., na.action = "na.omit")))

  out <- merge(coeffs, stats)
  out[["N"]] <- out[["df.residual"]] + 1
  NA_rows <- which(is.na(out[["slope"]]))

  if (length(NA_rows) != 0) {
    out[NA_rows, ] = NA
  }

  out
}