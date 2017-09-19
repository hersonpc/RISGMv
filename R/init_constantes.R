#Inicializa um setup de constantes
#
# @author Herson Melo <hersonpc@gmail.com>
# @desciption Ativa um pacote de constantes no ambiente global
# @examples init_constantes()
init_constantes <- function() {
	
	options(encoding = "UTF-8")

	constantes <- list(
					meses = list(
								curtos = 
									factor(c("Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"),
										levels = c("Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez") 
										)
									,
								longos = 
									factor(c("Janeiro","Fevereiro","Março","Abril","Maio","Junho",
											"Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"),
										levels = c("Janeiro","Fevereiro","Março","Abril","Maio","Junho",
											"Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")	
										)
									
								)
					)
	
	assign('constantes', constantes, envir = .GlobalEnv)
	
}
