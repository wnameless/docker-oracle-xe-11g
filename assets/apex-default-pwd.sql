set verify off feed off serveroutput on size unlimited

declare
    c_schema constant sys.dba_registry.schema%type := sys.dbms_registry.schema('APEX');
begin
    execute immediate 'alter session set current_schema='||sys.dbms_assert.enquote_name(c_schema);
end;
/

col user_id       noprint new_value M_USER_ID
col email_address noprint new_value M_EMAIL_ADDRESS
set termout off
select rtrim(min(user_id))       user_id,
       nvl (
           rtrim(min(email_address)),
           'ADMIN' )        email_address
  from wwv_flow_fnd_user
 where security_group_id = 10
   and user_name         = upper('ADMIN')
/
set termout on
begin
    if length('ADMIN') > 0 then
        sys.dbms_output.put_line('User "ADMIN" exists.');
    else
        sys.dbms_output.put_line('User "ADMIN" does not yet exist and will be created.');
    end if;
end;
/

declare
    c_user_id  constant number         := to_number( '&M_USER_ID.' );
    c_username constant varchar2(4000) := upper( 'ADMIN' );
    c_email    constant varchar2(4000) := 'ADMIN';
    c_password constant varchar2(4000) := 'Oracle_11g';

    c_old_sgid constant number := wwv_flow_security.g_security_group_id;
    c_old_user constant varchar2(255) := wwv_flow_security.g_user;

    procedure cleanup
    is
    begin
        wwv_flow_security.g_security_group_id := c_old_sgid;
        wwv_flow_security.g_user              := c_old_user;
    end cleanup;
begin
    wwv_flow_security.g_security_group_id := 10;
    wwv_flow_security.g_user              := c_username;

    wwv_flow_fnd_user_int.create_or_update_user( p_user_id  => c_user_id,
                                                 p_username => c_username,
                                                 p_email    => c_email,
                                                 p_password => c_password );

    commit;
    cleanup();
exception
    when others then
        cleanup();
        raise;
end;
/

prompt

exit
