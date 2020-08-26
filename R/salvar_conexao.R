#' Armazenada/Atualiza dados de uma conexao de banco de dados
#'
#' @author Herson Melo
#' @param name Nome da conexao salva (ex: 'default')
#' @param ip Endereço do serviçor de banco de dados
#' @param database Nome da instância do banco de dados
#' @param username Nome do usuário do banco de dados
#' @param password Senha de acesso ao banco de dados
#' @param db_type Determina o tipo de conexao ("oracle", "mysql")
#' @return TRUE ou FALSE, a depender do sucesso do armazenamento dos dados no dispositivo local.
#' @examples salvar_conexao(name = "default",
#' 			ip = "192.168.0.1",
#' 			database = "producao",
#' 			username = "dbamv",
#' 			password = "123456",
#' 			db_type = "oracle")
#' @export
salvar_conexao <- function(name = "default", ip, database, username, password, db_type = "oracle") {
  saved <- FALSE
	sqlite.filename <- file.path(Sys.getenv("HOME"), ".r", "risgmv.sqlite")
	setup_ambiente_oracle()

	stringConexao <- NULL
	string_conexao_oracle <- function(ip, database, porta = 1521) {
	  return (paste0("jdbc:oracle:thin:@", ip, ":", porta, ":", database))
	}
	string_conexao_mysql <- function(ip, database, porta = 3306) {
	  return (paste0("mysql@", ip, ":", porta, ":", database))
	}


	if(db_type == "oracle") {
	  stringConexao <- string_conexao_oracle(ip = ip, database = database)
	}
	if(db_type == "mysql") {
	  stringConexao <- string_conexao_mysql(ip = ip, database = database)
	}

	if(is.null(stringConexao)) {
	  stop("ConnectionString is not detected!")
	}

	tryCatch(
		{
			con <- DBI::dbConnect(RSQLite::SQLite(), dbname = sqlite.filename)
			DBI::dbExecute(con, 'CREATE TABLE IF NOT EXISTS conexoes (name TEXT primary key, stringConexao TEXT, username TEXT, password TEXT);')
			DBI::dbExecute(con, paste0('INSERT OR REPLACE INTO conexoes (name, stringConexao, username, password) VALUES ("', tolower(name),
									'", "', stringConexao, '", "', username, '", "', password, '")'))
			saved <- TRUE
		},
		error = function(cond) {
			warning(cond)
		}
	)
	DBI::dbDisconnect(con)

	return (saved)
}
