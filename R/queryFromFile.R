#' Executar Query armazeanda em um arquivo no banco de dados MV
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param sql_filename Caminho do arquivo contento a query SQL a ser executada
#' @param conexao_name Alias para acesso a conexao armazenada
#' @return Query executada no banco de dados
#' @export
queryFromFile <- function(sql_filename, conexao_name = "default") {

	if(!file.exists(sql_filename))
		stop(paste0("Arquivo SQL não encontrado: ", sql_filename))

	sql_query <- ler_arquivo(sql_filename)
	
	return (query(sql = sql_query, conexao_name = conexao_name))
}
