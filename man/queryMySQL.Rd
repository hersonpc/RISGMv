% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/queryMySQL.R
\name{queryMySQL}
\alias{queryMySQL}
\title{Executar Query em um banco de dados MySQL}
\usage{
queryMySQL(sql, connection_alias)
}
\arguments{
\item{sql}{Query SQL a ser executada ex: 'select * from tabela'}

\item{connection_alias}{Alias para acesso a conexao armazenada do tipo MySQL}
}
\value{
Lista com composição de dados da execução da query no banco de dados
}
\description{
Executa consulta o banco e retorna o resultado
}
\author{
Herson Melo
}
