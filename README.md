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

* **\<ip\>**	IP do servidor de banco de dados
* **\<porta\>**	Porta de uso do serviço de banco de dados
* **\<database\>** Nome da instancia do banco de dados
* **\<username\>** Nome do usuário para acesso ao banco de dados
* **\<password\>** Senha de acesso


```R
library("RISGMv")
save_conexao(name = "default",
	stringConexao = "jdbc:oracle:thin:@<ip>:<porta>:<database>",
	username = "<username>",
	password = "<password>")
```
