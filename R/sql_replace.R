#' Get Script Query stored
#'
#' @author Herson Melo <hersonpc@gmail.com>
#' @param text Original text
#' @param replacement Array with replecements c('find this' = 'replace with this')
#' @return Replaced text
#' @export
sqlReplace <- function(text, replacement = NULL) {
	if(exists("replacement")) {
	  if(!is.null(replacement)) {
	    message(paste0("\tReplacing sql strings (#", length(replacement), "): ", names(replacement)))
	    for (i in 1:length(replacement)) {
	      var_from = names(replacement)[i]
	      var_to   = replacement[i]

	      text <-
	         base::gsub(
	              var_from,
	              var_to,
	              text,
	              ignore.case = TRUE)
	    }
	  }
	}

	return (text)
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
