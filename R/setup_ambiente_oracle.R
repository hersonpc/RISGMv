setup_ambiente_oracle <- function() {

  if(Sys.getenv("HOME") == "")
    stop("ERROR - Java HOME path is not defined.")

	# Definindo os arquivos de armazenamento do banco local de conexoes
	sqlite.filename <- file.path(Sys.getenv("HOME"), ".r", "risgmv.sqlite")
	dir.create(dirname(sqlite.filename), recursive = T, showWarnings = FALSE)


	# Definindo o caminho da lib para acesso ao Oracle
	ojdbc6.url <- "https://github.com/hersonpc/RISGMv/raw/master/lib/ojdbc6.jar"
	ojdbc6.filename <- file.path(Sys.getenv("HOME"), ".r", "lib", "ojdbc6.jar")
	dir.create(dirname(ojdbc6.filename), recursive = T, showWarnings = FALSE)

	if(!file.exists(ojdbc6.filename)) {
		download.file(url = ojdbc6.url,
					  destfile = ojdbc6.filename,
					  method = "auto",
					  quiet = FALSE,
					  mode = "wb",
					  cacheOK = TRUE)
	}
	if(!file.exists(ojdbc6.filename))
		stop("ERROR - Oracle JDBC jar, nao foi encontrado")

	return (file.exists(ojdbc6.filename))
}
