# RISGMv (R Package)

Pacote R para facilitar o acesso aos dados do banco de dados Oracle

Promovendo uma maneira local de armazenamento dos dados de conexão e permitindo o armazenamento de multiplos dados de bancos diferentes, facilitando enormemente a dinamica de se trabalhar com os dados.


## Instalação

```R
# Instalar o pacote devtools
install.packages("devtools")

# Instalar via github
devtools::install_github("hersonpc/RISGMv")
```



## Configuração inicial

Substitua os seguintes dados no script abaixo:

* **\<name\>**	Alias para referencia futura aos dados
* **\<ip\>**	IP do servidor de banco de dados
* **\<database\>** Nome da instancia do banco de dados
* **\<username\>** Nome do usuário para acesso ao banco de dados
* **\<password\>** Senha de acesso
* **\<typd\>** Tipo de banco de dados (Oracle, MySQL)


```R
# Carregar a biblioteca
library("RISGMv")

# Salvar os dados desejados
salvar_conexao(name = "default",
	ip = "<ip>",
	database = "<database>",
	username = "<username>",
	password = "<password>",
	db_type = "<type>")
```

Para verificar as conexões salvas e seus respectivos dados:

```R
# Carregar a biblioteca
library("RISGMv")

# Exibe o nome das conexões armazenadas
listar_conexoes()

# Consulta os dados da conexão pelo seu nome
obter_conexao("default")
```



## Consumindo dados

Basta invocar a função **query()** ou  **queryMySQL()** (a depender a origem dos dados) e informar o código sql e opcionalmente o nome (apelido pre-cadastrado) da conexão.

```R
# Oracle
result <- 
  query(
      sql = "select count(*) total from atendime",
      connection_alias = "hdt")

# MySQL
result <- 
  queryMySQL(
    sql = "select count(*) total from atendime", 
    connection_alias = "banco-indicadores")
```

## Funções e Constantes Úteis

Para auxiliar na criação das analises o pacote contem algunas funções e constantes úteis para formatação dos dados.

```R
# Trazudir numeral do mês para o texto em pt-br
isgr_utils$traduzMesCurto(8)
isgr_utils$traduzMesCurto(c(2,8,12,1,2))

isgr_utils$traduzMesLongo(11)
isgr_utils$traduzMesLongo(c(11,9,2,7,10))

# Remover acentos
isgr_utils$removeAcentos("Função")
```
