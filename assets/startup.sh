#!/bin/bash

# Initialize the host's data volume, leaving a trace when finished.
if [ ! -e /u01/app/oracle/oradata/dataloaded ]
then
  cp -r /u01/app/oracle/oradata.orig/* /u01/app/oracle/oradata/
  touch /u01/app/oracle/oradata/dataloaded
  echo "Host data volume was initialized."
else
  echo "Data was loaded from the host."
fi

LISTENER_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
TNSNAMES_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora

cp "${LISTENER_ORA}.tmpl" "$LISTENER_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${LISTENER_ORA}" &&
sed -i "s/%port%/1521/g" "${LISTENER_ORA}" &&
cp "${TNSNAMES_ORA}.tmpl" "$TNSNAMES_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${TNSNAMES_ORA}" &&
sed -i "s/%port%/1521/g" "${TNSNAMES_ORA}" &&

service oracle-xe start

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=XE

if [ "$ORACLE_ALLOW_REMOTE" = true ]; then
  echo "alter system disable restricted session;" | sqlplus -s SYSTEM/oracle
fi

for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.sql)    echo "$0: running $f"; echo "exit" | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "SYSTEM/oracle" @"$f"; echo ;;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done
