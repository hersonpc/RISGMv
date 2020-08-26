#' Get Script Query stored
#'
#' @author Herson Melo
#' @param script Script name
#' @param replacement Array with replecements c('find this' = 'replace with this')
#' @param connection_alias Alias para acesso a conexao armazenada
#' @return Query Executed
#' @export
execStoredScript <- function(script, replacement = NULL, connection_alias = "default") {

	if(stringr::str_trim(script) == "")
		stop("ERROR - Script name not found")

  query_script <- paste0(sql = "select * from HERSON_SCRIPTS where script_name like '", script, "'")
	sql_query <- query(query_script, connection_alias = connection_alias)$SCRIPT

	if(stringr::str_trim(sql_query) == "")
	  stop("ERROR - Script content not found or invalid")

	sql_query <- sqlReplace(sql_query, replacement)

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
