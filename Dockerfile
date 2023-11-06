FROM ubuntu:16.04

ADD assets /assets
RUN assets/setup.sh
RUN mv /assets/startup.sh /usr/sbin/startup.sh

EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/usr/sbin/startup.sh"]
