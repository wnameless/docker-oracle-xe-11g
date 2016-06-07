#!/bin/bash
LISTENERS_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora

cp "${LISTENERS_ORA}.tmpl" "$LISTENERS_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${LISTENERS_ORA}" &&
sed -i "s/%port%/1521/g" "${LISTENERS_ORA}" &&

service oracle-xe start

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

if [ "$ORACLE_ALLOW_REMOTE" = true ]; then
  export PATH=$ORACLE_HOME/bin:$PATH
  export ORACLE_SID=XE
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
