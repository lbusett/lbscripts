replace_colnames <- function(in_data, oldnames, newnames) {

  if(any(names(in_data) %in% newnames)) {
    which_dup <- which(names(in_data) %in% newnames)
    for(dup in which_dup) {
      names(in_data)[dup] <- paste(names(in_data)[dup], "_old")
    }
  } else {

    col_indexes  <- which(names(in_data) %in% oldnames)
    subs_indexes <- as.numeric(na.omit(match(names(in_data), oldnames)))
    names(in_data)[col_indexes] <- newnames[subs_indexes]

  }

  return(in_data)
}