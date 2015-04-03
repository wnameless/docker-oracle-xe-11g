#!/bin/bash
case "$1" in
	'')
		sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
		/etc/init.d/oracle-xe start
		##
		## Workaround for graceful shutdown. ....ing oracle... ‿( ́ ̵ _-`)‿
		##
		trap '/etc/init.d/oracle-xe stop' INT TERM
		while [ 1 ]; do
		sleep 1
			true
		done
		;;

	*)
		$1
		;;
esac
