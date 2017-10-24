#' @title lb_linregr
#' @description FUNCTION_DESCRIPTION
#' @param in_data PARAM_DESCRIPTION
#' @param X_VAR PARAM_DESCRIPTION
#' @param Y_VAR PARAM_DESCRIPTION
#' @param GP_VAR PARAM_DESCRIPTION, Default: NULL
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
#' @importFrom data.table as.data.table
#' @importFrom dplyr group_by select rename mutate
#' @importFrom dumbify dumbify undumbify
#' @importFrom tidyr spread
#' @importFrom stats lm
lb_linregr <- function(in_data,
                       X_VAR,
                       Y_VAR,
                       GP_VAR = NULL,
                       na.rm  = TRUE) {

  # in_names <- c(x_var, y_var, group_var)
  # newnames <- c("X_VAR", "Y_VAR", "GP_VAR")

  in_data  <- dumbify::dumbify(in_data, c(X_VAR, Y_VAR, GP_VAR))
  #   ____________________________________________________________________________
  #   rename the names of the columns to be used in the regr- analysis to     ####
  #   X and Y

  if (class(in_data[["Y_VAR"]]) == "Date") {
    in_data[["Y_VAR"]] <- as.numeric(in_data[["Y_VAR"]])
  }


  #   ____________________________________________________________________________
  #   Compute regression coefficients and stats                               ####

  coeffs <- in_data %>%
    dplyr::group_by(GP_VAR) %>%
    do(broom::tidy(lm(Y_VAR ~ X_VAR, .))) %>%
    dplyr::select(., c("GP_VAR", "term", "estimate")) %>%
    tidyr::spread(term, estimate)

  names(coeffs)[2:3] <- c("intercept", "slope")

  stats <- in_data %>%
    dplyr::group_by(GP_VAR) %>%
    do(broom::glance(stats::lm(Y_VAR ~ X_VAR, ., na.action = "na.omit")))


  #   __________________________________________________________________________
  #   Reshape the results                                                   ####

  out <- merge(coeffs, stats) %>%
    dplyr::rename("r2" = r.squared,
           "adj_r2" = adj.r.squared,
           "p" = p.value) %>%
    dplyr::mutate(r = r2 ^ 0.5,
           N = df.residual + 1,
           lab = paste("Y =",
                       format(slope, digits = 1), "* X", ifelse(intercept < 0, "-", "+" ),
                       format(abs(intercept), digit = 1, scientific = F),
                       "; r^2 =", format(r2, digits = 1, scientific = F),
                       "; p =", format(p, digits = 1, scientific = F)),
           shortlab = paste("slope =", format(slope, digits = 1, scientific = F),
                            "; r^2 =",   format(r2,    digits = 1, scientific = F))) %>%
    dplyr::select(1, lab, N, intercept, slope, r2, p, adj_r2, r, df,
                  AIC, BIC, logLik, deviance, df.residual, shortlab) %>%
    data.table::as.data.table()

  #   ____________________________________________________________________________

  NA_rows <- which(is.na(out[["slope"]]))

  if (length(NA_rows) != 0) {
    out[NA_rows, ] = NA
  }
  #   __________________________________________________________________________
  # return out outputs ###

  # names(out)[which(names(out) == "GP_VAR")] <- group_var

  out <- dumbify::undumbify(out, c(X_VAR, Y_VAR, GP_VAR))
}