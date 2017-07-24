
init_package <- function() {
  require(devtools)
  # devtools::create()
  devtools::use_dev_version()
  devtools::use_data()
  devtools::use_readme_rmd()
  devtools::use_build_ignore()
  devtools::use_coverage()
  devtools::use_cran_comments()
  devtools::use_gpl3_license()
  devtools::use_rstudio()
  devtools::uses_testthat()
  devtools::use_vignette()
  devtools::use_travis()
  devtools::use_news_md()
}