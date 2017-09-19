# RISGMv (R Package)

Pacote R para facilitar o acesso aos dados do banco de dados Oracle

Promovendo uma maneira local de armazenamento dos dados de conexão e permitindo o armazenamento de multiplos dados de bancos diferentes, facilitando enormemente a dinamica de se trabalhar com os dados.


## Instalação

```R
# Instalar o pacote devtools
install.packages("devtools")
library("devtools")

# Instalar via github
install_github("hersonpc/RISGMv")
```



## Configuração inicial

Substitua os seguintes dados no script abaixo:

* **\<name\>**	Alias para referencia futura aos dados
* **\<ip\>**	IP do servidor de banco de dados
* **\<database\>** Nome da instancia do banco de dados
* **\<username\>** Nome do usuário para acesso ao banco de dados
* **\<password\>** Senha de acesso


```R
# Carregar a biblioteca
library("RISGMv")

# Salvar os dados desejados
salvar_conexao(name = "default",
	ip = "<ip>",
	database = "<database>",
	username = "<username>",
	password = "<password>")
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

Basta invocar a função **query()** e informar o código sql e opcionalmente o nome (apelido) da conexão.

```R
query("select count(*) total from atendime")
```