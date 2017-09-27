#' Lista o Alias das conexoes armazenadas localmente
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @return Retorna relação dos nomes das conexoes armazenadas localmente
#' @examples listar_conexoes(name = "default")
listar_conexoes <- function() {

	sqlite.filename <- file.path(Sys.getenv("HOME"), ".r", "risgmv.sqlite")
	setup_ambiente_oracle()

	if(!file.exists(sqlite.filename)) {
		warning("Nenhum dado consta armazenado neste dispositivo")
		return (NULL)
	}

	output <- NULL
	tryCatch(
		{
			con = DBI::dbConnect(RSQLite::SQLite(), dbname = sqlite.filename)
			output <- DBI::dbGetQuery(con, 'SELECT name FROM conexoes')
		},
		error = function(cond) {
			warning("Erro ao consultar arquivo de dados, reconstrua-o pelo comando 'salvar_conexao()'")
			# warning(cond)
		}
	)
	DBI::dbDisconnect(con)

	return (output)
}
