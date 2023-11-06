FROM ubuntu:18.04

COPY assets /assets
RUN mv /assets/startup.sh /usr/sbin/startup.sh
RUN /assets/setup.sh

EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/usr/sbin/startup.sh"]
