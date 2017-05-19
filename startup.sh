#!/bin/bash

echo ""
echo "Oracle XE 11g CI/Development image"
echo "By Epic Labs, 2017 - http://www.epiclabs.io"
echo ""
echo "https://github.com/epiclabs-io/docker-oracle-xe-11g"
echo "forked from wnameless/docker-oracle-xe-11g"
echo ""
echo ""



LISTENER_ORA=/u01/app/oracle-product/11.2.0/xe/network/admin/listener.ora
TNSNAMES_ORA=/u01/app/oracle-product/11.2.0/xe/network/admin/tnsnames.ora

cp "${LISTENER_ORA}.tmpl" "$LISTENER_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${LISTENER_ORA}" &&
sed -i "s/%port%/1521/g" "${LISTENER_ORA}" &&
cp "${TNSNAMES_ORA}.tmpl" "$TNSNAMES_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${TNSNAMES_ORA}" &&
sed -i "s/%port%/1521/g" "${TNSNAMES_ORA}" &&


rm -rf /u01/app/oracle/product

ln -s /u01/app/oracle-product /u01/app/oracle/product    #Mount database installation to the Expanded VOLUME of container

if [ ! -d /u01/app/oracle/dbs ] ; then
	echo "using default configuration"
	tar xf /u01/app/default-dbs.tar.gz -C /u01/app/oracle/
fi

if [ ! -d /u01/app/oracle/oradata ] ; then
	echo "using default data directory"
	tar xf /u01/app/default-oradata.tar.gz
fi

if [ ! -d /u01/app/oracle/admin ] ; then
	echo "using default admin directory"
	tar xf /u01/app/default-admin.tar.gz
fi

if [ ! -d /u01/app/oracle/fast_recovery_area ] ; then
	echo "using default fast_recovery_area directory"
	tar xf /u01/app/default-fast_recovery_area.tar.gz
fi

ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/xe/dbs    #Link db configuration to the installation path form extended volume with DB data

chown -R oracle:dba /u01/app/oracle

service oracle-xe start

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=XE


if [ ! -e "/u01/app/oracle/initialized.id" ] ; then

	echo "Performing initial database setup ..."

	if [ ! -z "$RELAX_SECURITY" ] ; then
		echo "WARNING: Relaxing profile security with no password reuse limits, etc. Use with caution ..."
		echo "CREATE PROFILE NOEXPIRY LIMIT
			  COMPOSITE_LIMIT UNLIMITED
			  PASSWORD_LIFE_TIME UNLIMITED
			  PASSWORD_REUSE_TIME UNLIMITED
			  PASSWORD_REUSE_MAX UNLIMITED
			  PASSWORD_VERIFY_FUNCTION NULL
			  PASSWORD_LOCK_TIME UNLIMITED
			  PASSWORD_GRACE_TIME UNLIMITED
			  FAILED_LOGIN_ATTEMPTS UNLIMITED;" | sqlplus -s SYSTEM/oracle
			  
		echo "ALTER USER SYSTEM PROFILE NOEXPIRY;" | sqlplus -s SYSTEM/oracle
		echo "ALTER USER SYS PROFILE NOEXPIRY;" | sqlplus -s SYSTEM/oracle
		echo "Security relaxed."
		
	fi

	if [ -z "$ORACLE_PASSWORD" ] ; then
		echo "Warning: using default password!!. Set ORACLE_PASSWORD environment variable to change it"
		export ORACLE_PASSWORD="oracle";
	else

		echo "Setting SYS password... "
		if ! echo "ALTER USER SYS IDENTIFIED BY \"$ORACLE_PASSWORD\";" | sqlplus -s SYSTEM/oracle ; then
			echo "Error setting SYS password."
			exit 1;
		fi
		
		echo "Setting SYSTEM password... "
		
		if	! echo "ALTER USER SYSTEM IDENTIFIED BY \"$ORACLE_PASSWORD\";" | sqlplus -s SYSTEM/oracle  ; then
			echo "Error setting SYSTEM password."
			exit 1;
		fi
	fi
	
	touch "/u01/app/oracle/initialized.id"
fi



if [ "$ORACLE_ALLOW_REMOTE" = true ]; then
  echo "alter system disable restricted session;" | sqlplus -s "SYSTEM/$ORACLE_PASSWORD"
fi

echo "Running startup scripts ..."

for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.sql)    echo "$0: running $f"; echo "exit" | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "SYS/$ORACLE_PASSWORD" AS SYSDBA @"$f"; echo ;;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done


echo -e "\n\n Bring it on!! \n\n"

tail -fn 0 /u01/app/oracle/diag/rdbms/xe/XE/trace/alert_XE.log

echo -e '\n\nShutting down...\n\n'
service oracle-xe stop 

echo -e "\nbye\n"
