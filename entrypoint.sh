#!/bin/bash

# Prevent owner issues on mounted folders
chown -R oracle:dba /u01/app/oracle
rm -f /u01/app/oracle/product
ln -s /u01/app/oracle-product /u01/app/oracle/product
# Update hostname
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
sed -i -E "s/PORT = [^)]+/PORT = 1521/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" > /etc/profile.d/oracle-xe.sh
echo "export PATH=\$ORACLE_HOME/bin:\$PATH" >> /etc/profile.d/oracle-xe.sh
echo "export ORACLE_SID=XE" >> /etc/profile.d/oracle-xe.sh
. /etc/profile

case "$1" in
	'')
		#Check for mounted database files
		if [ "$(ls -A /u01/app/oracle/oradata)" ]; then
			echo "found files in /u01/app/oracle/oradata Using them instead of initial database"
			echo "XE:$ORACLE_HOME:N" >> /etc/oratab
			chown oracle:dba /etc/oratab
			chown 664 /etc/oratab
			printf "ORACLE_DBENABLED=false\nLISTENER_PORT=1521\nHTTP_PORT=8080\nCONFIGURE_RUN=true\n" > /etc/default/oracle-xe
			rm -rf /u01/app/oracle-product/11.2.0/xe/dbs
			ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/xe/dbs
		else
			echo "Database not initialized. Initializing database."
			mv /u01/app/oracle-product/11.2.0/xe/dbs /u01/app/oracle/dbs
			ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/xe/dbs
			printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure
			echo "Database initialized. Please visit http://#containeer:8080/apex to proceed with configuration"
		fi

		/etc/init.d/oracle-xe start
		echo "Database ready to use. Enjoy! ;)"

		##
		## Workaround for graceful shutdown. ....ing oracle... ‿( ́ ̵ _-`)‿
		##
		while [ "$END" == '' ]; do
			sleep 1
			trap "/etc/init.d/oracle-xe stop && END=1" INT TERM
		done
		;;

	*)
		echo "Database is not configured. Please run /etc/init.d/oracle-xe configure if needed."
		$1
		;;
esac
