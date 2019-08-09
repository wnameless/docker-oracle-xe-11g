FROM ubuntu:18.04

MAINTAINER Wei-Ming Wu <wnameless@gmail.com>

COPY assets /assets
RUN /assets/setup.sh

EXPOSE 22
EXPOSE 1521
EXPOSE 8080

CMD /usr/sbin/startup.sh && tail -f /dev/null
