#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive

cat /assets/oracle-xe_11.2.0-1.0_amd64.deba* > /assets/oracle-xe_11.2.0-1.0_amd64.deb

apt-get update

# Prepare to install Oracle
apt-get install -y libaio1 net-tools bc &&
ln -s /usr/bin/awk /bin/awk &&
mkdir /var/lock/subsys &&
mv /assets/chkconfig /sbin/chkconfig &&
chmod 755 /sbin/chkconfig &&

# Install Oracle
dpkg --install /assets/oracle-xe_11.2.0-1.0_amd64.deb &&

# Backup listener.ora as template
cp /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora.tmpl &&
cp /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora.tmpl &&

mv /assets/init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts &&
mv /assets/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts &&

printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure &&

echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc &&
echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc &&
echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc &&
# Remove installation files
rm -r /assets/

mv /u01/app/oracle/product /u01/app/oracle-product
pushd /u01/app/oracle-product/11.2.0/xe/
tar zcvf /u01/app/default-dbs.tar.gz dbs
rm -rf dbs/
popd
 
tar zcvf /u01/app/default-admin.tar.gz /u01/app/oracle/admin && rm -rf /u01/app/oracle/admin
tar zcvf /u01/app/default-oradata.tar.gz /u01/app/oracle/oradata && rm -rf /u01/app/oracle/oradata
tar zcvf /u01/app/default-fast_recovery_area.tar.gz /u01/app/oracle/fast_recovery_area && rm -rf /u01/app/oracle/fast_recovery_area

# Install startup script for container


exit $?
