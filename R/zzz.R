.onAttach <- function(libname, pkgname) {
  # to show a startup message
  packageStartupMessage("RISGMv 0.0.2 by Herson Melo <hersonpc@gmail.com>")
  init_constantes()
}

.onLoad <- function(libname, pkgname){
  #message("RISGMv - loaded!")
  #init_constantes()
}
