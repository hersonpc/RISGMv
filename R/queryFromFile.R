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

	if(exists("replacement")) {
	  if(!is.null(replacement)) {
	    message(paste0("\tReplacing sql strings (#", length(replacement), "): ", names(replacement)))
	    for (i in 1:length(replacement)) {
	      var_from = names(replacement)[i]
	      var_to   = replacement[i]

	      sql_query <- gsub(var_from,
	                      var_to,
	                      sql_query,
	                      ignore.case = TRUE)
	    }
	  }
	}

	return (query(sql = sql_query, conexao_name = connection_alias))
}
