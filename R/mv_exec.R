#' Executar Query no banco de dados MV
#'
#' Exibe a mensagem de ola mundo
#' @author Herson Melo <hersonpc@gmail.com>
#' @param query Query SQL a ser executada
#' @return Conexao ao banco
#' @export
mv_exec <- function(query) {
  db_ip <- readline("Qual IP do banco de dados? ")
  db_name <- readline("Qual nome da conexão com o DB? ")

  print(db_ip)
  return ("Hello, world!")
}
