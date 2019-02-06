#' Execute query in database
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param sql Query SQL to be executed: 'INSERT INTO cars (speed, dist) VALUES (1, 1), (2, 2), (3, 3);'
#' @param connection_alias Alias para acesso a conexao armazenada
#' @return TRUE if executed without errors
#' @export
query <- function(sql, connection_alias = "default") {

	setup_ambiente_oracle()

	conexao <- obter_conexao(connection_alias)

	output <- FALSE
	tryCatch(
		{
			ojdbc6.filename <- file.path(Sys.getenv("HOME"), ".r", "lib", "ojdbc6.jar")
			drvOracle <- RJDBC::JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = ojdbc6.filename)
			con <- DBI::dbConnect(drvOracle, conexao$stringConexao, as.character(conexao$username), as.character(conexao$password))

			DBI::dbExecute(con, sql)
			output <- TRUE

			DBI::dbDisconnect(con)
		},
		error = function(cond) {
			warning(cond)
		}
	)

	return (output)
}
