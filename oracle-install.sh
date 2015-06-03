#!/bin/bash
wget -q 'https://github.com/MaksymBilenko/docker-oracle-xe-11g/blob/master/oracle-xe_11.2.0-1.0_amd64.debaa?raw=true' -O /oracle-xe_11.2.0-1.0_amd64.debaa
wget -q 'https://github.com/MaksymBilenko/docker-oracle-xe-11g/blob/master/oracle-xe_11.2.0-1.0_amd64.debab?raw=true' -O /oracle-xe_11.2.0-1.0_amd64.debab
wget -q 'https://github.com/MaksymBilenko/docker-oracle-xe-11g/blob/master/oracle-xe_11.2.0-1.0_amd64.debac?raw=true' -O /oracle-xe_11.2.0-1.0_amd64.debac
cat /oracle-xe_11.2.0-1.0_amd64.deba* > /oracle-xe_11.2.0-1.0_amd64.deb
dpkg --install /oracle-xe_11.2.0-1.0_amd64.deb
rm -f /oracle-xe_11.2.0-1.0_amd64.deb* 

mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

mv /u01/app/oracle/product /u01/app/oracle-product

apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*