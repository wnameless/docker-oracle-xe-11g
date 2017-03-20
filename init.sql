CREATE USER flywayrecebimento IDENTIFIED BY oracle ACCOUNT UNLOCK QUOTA unlimited on SYSTEM;
GRANT CREATE SESSION TO flywayrecebimento;
GRANT DBA TO flywayrecebimento;

CREATE USER recebimento IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER usuariorecebimento IDENTIFIED BY oracle ACCOUNT UNLOCK;
GRANT CREATE SESSION TO usuariorecebimento;
CREATE ROLE rs_recebimento;
GRANT rs_recebimento TO usuariorecebimento;
ALTER USER usuariorecebimento DEFAULT ROLE rs_recebimento; 

CREATE USER flywayautuacao IDENTIFIED BY oracle ACCOUNT UNLOCK QUOTA unlimited on SYSTEM;
GRANT CREATE SESSION TO flywayautuacao;
GRANT DBA TO flywayautuacao;

CREATE USER autuacao IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER activitiautuacao IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER usuarioautuacao IDENTIFIED BY oracle ACCOUNT UNLOCK;
GRANT CREATE SESSION TO usuarioautuacao;
CREATE ROLE rs_autuacao;
GRANT rs_autuacao TO usuarioautuacao;
ALTER USER usuarioautuacao DEFAULT ROLE rs_autuacao;

CREATE USER flywaydocuments IDENTIFIED BY oracle ACCOUNT UNLOCK QUOTA unlimited on SYSTEM;
GRANT CREATE SESSION TO flywaydocuments;
GRANT DBA TO flywaydocuments;

CREATE USER documents IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER usuariodocuments IDENTIFIED BY oracle ACCOUNT UNLOCK;
GRANT CREATE SESSION TO usuariodocuments;
CREATE ROLE rs_documents;
GRANT rs_documents TO usuariodocuments;
ALTER USER usuariodocuments DEFAULT ROLE rs_documents;

CREATE USER flywayidentidades IDENTIFIED BY oracle ACCOUNT UNLOCK QUOTA unlimited on SYSTEM;
GRANT CREATE SESSION TO flywayidentidades;
GRANT DBA TO flywayidentidades;

CREATE USER identidades IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER corporativo IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER configuracao IDENTIFIED BY oracle ACCOUNT LOCK QUOTA unlimited on SYSTEM;
CREATE USER usuarioidentidades IDENTIFIED BY oracle ACCOUNT UNLOCK;
GRANT CREATE SESSION TO usuarioidentidades;
CREATE ROLE rs_identidades;
CREATE ROLE rs_corporativo;
CREATE ROLE rs_configuracao;
GRANT rs_identidades, rs_corporativo, rs_configuracao TO usuarioidentidades;
ALTER USER usuarioidentidades DEFAULT ROLE rs_identidades, rs_corporativo, rs_configuracao;
