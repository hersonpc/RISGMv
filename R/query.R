#' Executar Query no banco de dados MV
#'
#' Exibe a mensagem de ola mundo
#' @author Herson Melo <hersonpc@gmail.com>
#' @param sql Query SQL a ser executada ex: 'select * from tabela'
#' @param conexao_name Alias para acesso a conexao armazenada
#' @return Query executada no banco de dados
#' @export
query <- function(sql, conexao_name = "default") {

	setup_ambiente_oracle()

	conexao <- obter_conexao(conexao_name)

	output <- NULL
	tryCatch(
		{
			ojdbc6.filename <- file.path(Sys.getenv("HOME"), ".r", "lib", "ojdbc6.jar")
			drvOracle <- RJDBC::JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = ojdbc6.filename)
			con <- DBI::dbConnect(drvOracle, conexao$stringConexao, as.character(conexao$username), as.character(conexao$password))
			res = DBI::dbSendQuery(con, sql)
			output = DBI::fetch(res, n = -1)
			DBI::dbClearResult(res)

			DBI::dbDisconnect(con)
		},
		error = function(cond) {
			warning(cond)
		}
	)

	return (output)
}
