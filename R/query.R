#' Executar Query no banco de dados MV
#'
#' Exibe a mensagem de ola mundo
#' @author Herson Melo <hersonpc@gmail.com>
#' @param sql Query SQL a ser executada ex: 'select * from tabela'
#' @param conexao_name Alias para acesso a conexao armazenada
#' @return Query executada no banco de dados
#' @export
query <- function(sql = "", conexao_name = "default") {

	setup_ambiente_oracle()

	conexao <- get_conexao(conexao_name)
	
	output <- NULL
	tryCatch(
		{
			ojdbc6.filename <- file.path(Sys.getenv("HOME"), ".r", "lib", "ojdbc6.jar")
			drvOracle <- RJDBC::JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = ojdbc6.filename)
			con <- dbConnect(drvOracle, conexao$stringConexao, as.character(conexao$username), as.character(conexao$password))
			res = dbSendQuery(con, sql)
			output = fetch(res, n = -1)
			dbClearResult(res)
			
			dbDisconnect(con)
		},
		error = function(cond) {
			warning(cond)
		}
	)
	
	return (output)
}
