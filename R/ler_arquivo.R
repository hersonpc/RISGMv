#' Le um arquivo e obtem seu conteudo
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param filename Caminho do arquivo a ser lido
#' @return Conteudo do arquivo
#' @export
ler_arquivo <- function(filename) {

	if(!file.exists(filename))
		stop(paste0("Arquivo SQL não encontrado: ", filename))

	# Lendo o arquivo...
	con <- file(filename, "r")
	texto <- ""

	while (TRUE) {
		line <- readLines(con, n = 1, warn = FALSE)
		if ( length(line) == 0 ) { break }

		line <- gsub("\\t", " ", line)

		if(grepl("--", line) == TRUE)
		{
		  line <- paste(sub("--", "/*", line), "*/")
		}
		texto <- paste(texto, line)
	}
	close(con)
	
	
	return (texto) 
}
