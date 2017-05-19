FROM ubuntu:16.04

MAINTAINER Javier Peletier <jm@epiclabs.io>

ADD assets /assets
ADD /setup.sh /
RUN /setup.sh
ADD /startup.sh /usr/sbin/startup.sh



EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/usr/sbin/startup.sh"]
