#!/bin/bash

mv /u01/app/oracle/product /u01/app/oracle-product
mv /u01/app/oracle-product/11.2.0/xe/dbs /u01/app/default-dbs
mv /u01/app/oracle/admin /u01/app/default-admin
mv /u01/app/oracle/oradata /u01/app/default-oradata
mv /u01/app/oracle/fast_recovery_area /u01/app/default-fast_recovery_area

# Install startup script for container

chmod +x /usr/sbin/startup.sh
