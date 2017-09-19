string_conexao_oracle <- function(ip, database, porta = 1521) {
	return (paste0("jdbc:oracle:thin:@", ip, ":", porta, ":", database))
}
