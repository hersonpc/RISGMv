#' Get Script Query stored
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param script Script name
#' @param replacement Array with replecements c('find this' = 'replace with this')
#' @param conexao_name Alias para acesso a conexao armazenada
#' @return Query Executed
#' @export
execStoredScript <- function(script, replacement = NULL, connection_alias = "default") {

	if(stringr::str_trim(script) == "")
		stop("ERROR - Script name not found")

  query_script <- paste0(sql = "select * from HERSON_SCRIPTS where script_name like '", script, "'")
	sql_query <- query(query_script, connection_alias = connection_alias)$SCRIPT

	if(stringr::str_trim(sql_query) == "")
	  stop("ERROR - Script content not found or invalid")

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

	return (query(sql = sql_query, connection_alias = connection_alias))
}



# CREATE SEQUENCE HERSON_SCRIPTS_SEQ START WITH 1;
#
# -- SELECT HERSON_SCRIPTS_SEQ.NEXTVAL from dual;
#
# CREATE TABLE HERSON_SCRIPTS (
#   ID NUMBER(11) NOT NULL,
#   SCRIPT_NAME VARCHAR2(30),
#   SCRIPT_DESCRIPTION VARCHAR2(1000),
#   SCRIPT CLOB,
#   CREATED_AT TIMESTAMP,
#   UPDATED_AT TIMESTAMP
# );
#
#
# ALTER TABLE HERSON_SCRIPTS ADD (
#   CONSTRAINT HERSON_SCRIPTS_PK PRIMARY KEY (ID));
# /
#
#   CREATE OR REPLACE TRIGGER HERSON_SCRIPTS_TGR
# BEFORE INSERT ON HERSON_SCRIPTS
# FOR EACH ROW
# BEGIN
# SELECT HERSON_SCRIPTS_SEQ.NEXTVAL
# INTO   :new.id
# FROM   dual;
# END;
# /
