#' Write data frames in database as a table
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param table_name Table name in database
#' @param delete_table_if_exists If TRUE and table exists in database, it will be deleted
#' @param conexao_name Alias name for connection stored in local machine
#' @return TRUE or FALSE if table has created
#' @export
write <- function(df, table_name, delete_table_if_exists = FALSE, conexao_name = "default") {

  # Check table name
  table_name = stringr::str_trim(table_name)
  if(!exists("table_name") | is.null(table_name) | length(stringr::str_trim(table_name)) <= 0)
      stop("ERROR - Table name not defined")

  # Setup
	setup_ambiente_oracle()

	# Connection
	conexao <- obter_conexao(conexao_name)

	# Run
	success <- FALSE
	tryCatch(
		{
			ojdbc6.filename <- file.path(Sys.getenv("HOME"), ".r", "lib", "ojdbc6.jar")
			drvOracle <- RJDBC::JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = ojdbc6.filename)
			con <- DBI::dbConnect(drvOracle, conexao$stringConexao, as.character(conexao$username), as.character(conexao$password))

			if(delete_table_if_exists & DBI::dbExistsTable(con, table_name))
			  DBI::dbRemoveTable(con, table_name)

			# Write the data frame to the database
			dbWriteTable(con, name = table_name, value = df, row.names = FALSE)
			DBI::dbDisconnect(con)
			success <- TRUE
		},
		error = function(cond) {
			warning(cond)
		}
	)

	return (success)
}
