<<<<<<< HEAD
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
=======
init_package <- function(pkgname) {
  require(devtools)
  devtools::create(pkgname)
  devtools::use_news_md(pkgname)
  devtools::use_data(pkgname)
  devtools::use_readme_rmd(pkgname)
  devtools::use_build_ignore(pkgname)
  devtools::use_coverage(pkgname)
  devtools::use_cran_comments(pkgname)
  devtools::use_gpl3_license(pkgname)
  devtools::use_rstudio(pkgname)
  devtools::uses_testthat(pkgname)
  devtools::use_vignette(pkgname)
  devtools::use_travis(pkgname)
>>>>>>> master
}
