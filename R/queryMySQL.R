#' Executar Query em um banco de dados MySQL
#'
#' Executa consulta o banco e retorna o resultado
#' @author Herson Melo
#' @param sql Query SQL a ser executada ex: 'select * from tabela'
#' @param connection_alias Alias para acesso a conexao armazenada do tipo MySQL
#' @return Lista com composição de dados da execução da query no banco de dados
#' @export
queryMySQL <- function(sql, connection_alias) {

  conexao <- obter_conexao(connection_alias)

  if(length(connection_alias) == 0) {
    stop("MySQL connection is not defined!")
  }
  conexao <- obter_conexao(connection_alias)
  if(length(conexao$stringConexao) == 0) {
    stop("MySQL connection is not detected!")
  }
  if(!stringr::str_detect(conexao$stringConexao, "mysql")){
    stop("Invalid MySQL connection selected!")
  }
  split_string <- stringr::str_split(conexao$stringConexao, "@", simplify = T)[,2]
  split_string <- stringr::str_split(split_string, pattern = ":", simplify = T)

  db_params <- list(
    user = conexao$username,
    password = conexao$password,
    host = split_string[,1],
    port = as.integer(split_string[,2]),
    name = split_string[,3]
  )

  output <- NULL
  start_time <- Sys.time()
  tryCatch(
    {
      mydb <-  DBI::dbConnect(RMySQL::MySQL(),
                              user = db_params$user,
                              password = db_params$password,
                              dbname = db_params$name,
                              host = db_params$host,
                              port = db_params$port)
      DBI::dbGetQuery(mydb, "SET NAMES utf8")

      res <- DBI::dbSendQuery(mydb, sql)
      output <-  DBI::fetch(res, n = -1)
      DBI::dbClearResult(res)

      DBI::dbDisconnect(mydb)
    },
    error = function(cond) {
      warning(cond)
    }
  )

  return(
    list(
          sql = sql,
          data = dplyr::as_tibble(output),
          created_at = Sys.time(),
          elapsed_time = (Sys.time() - start_time)
    )
  )
}
