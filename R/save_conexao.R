#' Consulta o respositorio local e retorna a string de conexao armazenada
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param name Nome da conexao salva (ex: 'default')
#' @return String de conexao para acesso ao banco
save_conexao <- function(name = "default", stringConexao, username, password) {
	saved <- FALSE
	sqlite.filename <- file.path(Sys.getenv("HOME"), ".r", "risgmv.sqlite")
	setup_ambiente_oracle()
	
	tryCatch(
		{
			con <- dbConnect(RSQLite::SQLite(), dbname = sqlite.filename)
			dbExecute(con, 'CREATE TABLE IF NOT EXISTS conexoes (name TEXT primary key, stringConexao TEXT, username TEXT, password TEXT);')
			dbExecute(con, paste0('INSERT OR REPLACE INTO conexoes (name, stringConexao, username, password) VALUES ("', tolower(name), 
									'", "', stringConexao, '", "', username, '", "', password, '")'))
			saved <- TRUE
		},
		error = function(cond) {
			warning(cond)
		}
	)
	dbDisconnect(con)
	
	return (saved)
}


# save_conexao("HDT", "jdbc:oracle:thin:@192.168.10.1:1521:hdtprd", "dbamv", "mv#*2012")
# save_conexao("CS", "jdbc:oracle:thin:@192.168.10.1:1521:Csprd", "dbamv", "dbamv")