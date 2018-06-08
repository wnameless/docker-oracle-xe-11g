set verify off

column port new_val HTTPPORT

select decode(xdb.dbms_xdb.gethttpport,0,8080,xdb.dbms_xdb.gethttpport) port from dual;

whenever sqlerror exit

set serveroutput on
declare
    l_port  number;
begin
    l_port := to_number('8080');
    xdb.dbms_xdb.sethttpport(l_port);
    commit;
exception when others then
    sys.dbms_output.put_line('***********************************');
    sys.dbms_output.put_line('* Invalid port number...          *');
    sys.dbms_output.put_line('***********************************');
    raise;
end;
/

exit