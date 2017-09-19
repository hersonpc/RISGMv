.onAttach <- function(libname, pkgname) {
  # to show a startup message
  packageStartupMessage("RISGMv by Herson Melo <hersonpc@gmail.com>")
  init_constantes()
}

.onLoad <- function(libname, pkgname){
  #message("RISGMv - loaded!")
  #init_constantes()
}