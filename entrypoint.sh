#!/bin/bash

sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora

case "$1" in
	'')
		#Check for mounted database files
		if [ "$(ls -A /u01/app/oracle/oradata)" ]; then
			echo "found files in /u01/app/oracle/oradata Using them instead of initial database"
		else
			echo "Database not initialized. Initializing database."
			echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" >> /etc/bash.bashrc
			echo "export PATH=$ORACLE_HOME/bin:$PATH" >> /etc/bash.bashrc
			echo "export ORACLE_SID=XE" >> /etc/bash.bashrc
			printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure
			/etc/init.d/oracle-xe stop || true
			echo "Database initialized. Please visit http://#containeer:8080/apex to proceed with configuration"
		fi

		/etc/init.d/oracle-xe start
		echo "Database ready to use. Enjoy! ;)"

		##
		## Workaround for graceful shutdown. ....ing oracle... ‿( ́ ̵ _-`)‿
		##
		trap "/etc/init.d/oracle-xe stop && kill -9 $$" INT TERM
		while [ 1 ]; do
			sleep 1
			true
		done
		;;

	*)
		echo "Database is not configured. Please run /etc/init.d/oracle-xe configure if needed."
		$1
		;;
esac
