#' Armazenada/Atualiza dados de uma conexao de banco de dados
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param name Nome da conexao salva (ex: 'default')
#' @param ip Endereço do serviçor de banco de dados
#' @param database Nome da instância do banco de dados
#' @param username Nome do usuário do banco de dados
#' @param password Senha de acesso ao banco de dados
#' @return TRUE ou FALSE, a depender do sucesso do armazenamento dos dados no dispositivo local.
#' @examples salvar_conexao(name = "default", 
#' 			ip = "192.168.0.1", 
#' 			database = "producao", 
#' 			username = "dbamv", 
#' 			password = "123456")
#' @export
salvar_conexao <- function(name = "default", ip, database, username, password) {
	saved <- FALSE
	sqlite.filename <- file.path(Sys.getenv("HOME"), ".r", "risgmv.sqlite")
	setup_ambiente_oracle()

	stringConexao <- string_conexao_oracle(ip = ip, database = database)
	
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

# salvar_conexao(name = "HDT", ip = "192.168.10.1", database = "hdtprd", username = "dbamv", password = "mv#*2012")
# salvar_conexao(name = "CS", ip = "192.168.10.1", database = "Csprd", username = "dbamv", password = "dbamv")

# Deprecated:
# save_conexao("HDT", "jdbc:oracle:thin:@192.168.10.1:1521:hdtprd", "dbamv", "mv#*2012")
# save_conexao("CS", "jdbc:oracle:thin:@192.168.10.1:1521:Csprd", "dbamv", "dbamv")
