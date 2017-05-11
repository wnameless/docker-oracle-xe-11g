FROM ubuntu:16.04

MAINTAINER fbenbrahim <fbenbrahim@soprahr.com>

ADD assets /assets
RUN /assets/setup.sh

EXPOSE 22
EXPOSE 1521
EXPOSE 8080

CMD /usr/sbin/startup.sh && /usr/sbin/sshd -D
