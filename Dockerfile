FROM ubuntu:18.04

COPY assets /assets
RUN /assets/setup.sh
RUN mv /assets/startup.sh /usr/sbin/startup.sh

EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/usr/sbin/startup.sh"]
