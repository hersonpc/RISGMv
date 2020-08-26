#' Write data frames in database as a table
#'
#' @author Herson Melo
#' @param df Tabela de dados
#' @param table_name Table name in database
#' @param delete_table_if_exists If TRUE and table exists in database, it will be deleted
#' @param append Append parameter for dbWriteTable
#' @param overwrite Overwrite parameter for dbWriteTable
#' @param row.names Row.names parameter for dbWriteTable
#' @param conexao_name Alias name for connection stored in local machine
#' @return TRUE or FALSE if table has created
#' @export
writeTable <- function(df, table_name, delete_table_if_exists = FALSE,
                       append = FALSE, overwrite = FALSE, row.names = FALSE, conexao_name = "default") {

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

			if(delete_table_if_exists) {
			  message("\t- Delete if exists...")
			  if(DBI::dbExistsTable(con, table_name)) {
			    message("\t- Removing existis table")
			    DBI::dbRemoveTable(con, table_name)
			  } else {
			    message("\t- not exists...")
			  }
			} else {
			  message("\t- not delete_table_if_exists")
			}

			# Write the data frame to the database
			DBI::dbWriteTable(conn = con, name = table_name, value = df,
			                  append = append, overwrite = overwrite, row.names = row.names)
			DBI::dbCommit(con)
			DBI::dbDisconnect(con)
			success <- TRUE
		},
		error = function(cond) {
			warning(cond)
		}
	)

	return (success)
}
