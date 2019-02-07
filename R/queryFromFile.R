#' Executar Query armazeanda em um arquivo no banco de dados MV
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param sql_filename Caminho do arquivo contento a query SQL a ser executada
#' @param conexao_name Alias para acesso a conexao armazenada
#' @return Query executada no banco de dados
#' @export
queryFromFile <- function(fileName, replacement = NULL, connection_alias = "default") {

	if(!file.exists(fileName))
		stop(paste0("ERROR - File not found: ", fileName))

	sql_query <- ler_arquivo(fileName)

	sql_query <- sqlReplace(sql_query, replacement)

	return (query(sql = sql_query, connection_alias = connection_alias))
}
