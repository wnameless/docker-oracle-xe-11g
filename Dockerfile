FROM ubuntu:14.04.1

MAINTAINER Maksym Bilenko <sath891@gmail.com>

ADD entrypoint.sh /
ADD chkconfig /sbin/chkconfig
ADD oracle-install.sh /oracle-install.sh
ADD init.ora /
ADD initXETemp.ora /

# Prepare to install Oracle
RUN apt-get update && apt-get install -y libaio1 net-tools bc wget && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN ln -s /usr/bin/awk /bin/awk
RUN mkdir /var/lock/subsys
RUN chmod 755 /sbin/chkconfig

# Install Oracle
RUN /oracle-install.sh

EXPOSE 1521
EXPOSE 8080
VOLUME ["/u01/app/oracle/oradata"]

ENTRYPOINT ["/entrypoint.sh"]