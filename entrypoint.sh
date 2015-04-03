#!/bin/bash
case "$1" in
	'')
		sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
		#Check for mounted database files
		if [ "$(ls -A /u01/app/oracle/oradata)" ]; then
			echo "found files in /u01/app/oracle/oradata Using them instead of initial database"
		else
			echo "Database not initialized. Using initial database."
			mv /u01/app/oracle/oradata{_initial/*,/}
		fi

		/etc/init.d/oracle-xe start
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
		$1
		;;
esac
