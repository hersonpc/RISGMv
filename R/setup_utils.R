#' Obtem funcoes uteis
#'
#' @author Herson Melo
#' @return Lista de constantes e funcoes uteis
#' @export
setup_utils <- function() {

  meses_curtos <- c("Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez")
  meses_longos <- c("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")

  fn_short <- function(mes) {
    if(dplyr::between(as.integer(mes), 1, 12)) {
      return(meses_curtos[mes])
    }
    return(NA)
  }
  fn_long <- function(mes) {
    if(dplyr::between(as.integer(mes), 1, 12)) {
      return(meses_longos[mes])
    }
    return(NA)
  }

  traduzMes <- function(mes, FUN) {
    if(!is.numeric(mes)) {
      return(NA)
    }

    if(is.vector(mes))
      return(sapply(mes, FUN))

    return(FUN(mes))
  }

  output <-
      list(
        meses_curtos = factor(meses_curtos, levels = meses_curtos),
        meses_longos = factor(meses_longos, levels = meses_longos),
        traduzMesCurto = function(mes){return(traduzMes(mes, fn_short))},
        traduzMesLongo = function(mes){return(traduzMes(mes, fn_long))},
        removeAcentos = function(str, pattern = "all") {return(remove_acentos(str, pattern))}
      )

  assign('isgr_utils', output, envir = .GlobalEnv)

  return(output)
}

