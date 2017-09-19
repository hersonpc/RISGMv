#' Obtem os dados da conexao armazenada localmente
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param name Nome (Alias) da conexao armazenada
#' @return Dados de conexao para acesso ao banco de dados
#' @examples obter_conexao(name = "default")
obter_conexao <- function(name = "default") {

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
