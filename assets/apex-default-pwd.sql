alter session set current_schema = APEX_040000;

begin

    wwv_flow_security.g_security_group_id := 10;
    wwv_flow_security.g_user := 'ADMIN';
    wwv_flow_security.g_import_in_progress := true;

    for c1 in (select user_id
                 from wwv_flow_fnd_user
                where security_group_id = wwv_flow_security.g_security_group_id
                  and user_name = wwv_flow_security.g_user) loop

        wwv_flow_fnd_user_api.edit_fnd_user(
            p_user_id       => c1.user_id,
            p_user_name     => wwv_flow_security.g_user,
            p_web_password  => 'admin',
            p_new_password  => 'admin');
    end loop;

    wwv_flow_security.g_import_in_progress := false;

end;
/
commit;