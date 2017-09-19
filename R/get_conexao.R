#' Consulta o respositorio local e retorna a string de conexao armazenada
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param name Nome da conexao armazenada
#' @return Dados de conexao para acesso ao banco de dados
get_conexao <- function(name = "default") {

	sqlite.filename <- file.path(Sys.getenv("HOME"), ".r", "risgmv.sqlite")
	setup_ambiente_oracle()

	if(!file.exists(sqlite.filename)) {
		warning("Nenhum dado consta armazenado neste dispositivo")
		return (NULL)
	}
	
	stringConexao <- NULL
	tryCatch(
		{
			con = dbConnect(RSQLite::SQLite(), dbname = sqlite.filename)
			stringConexao <- dbGetQuery(con, paste0('SELECT * FROM conexoes where name like "', tolower(name), '" '))
		},
		error = function(cond) {
			warning("Erro ao consultar arquivo de dados, reconstrua-o pelo comando 'save_conexao()'")
			# warning(cond)
		}
	)
	dbDisconnect(con)
	
	return (stringConexao)
}
