docker-oracle-xe-11g
============================
[![](https://badge.imagelayers.io/sath89/oracle-xe-11g:latest.svg)](https://imagelayers.io/?images=sath89/oracle-xe-11g:latest 'Get your own badge on imagelayers.io')

Oracle Express Edition 11g Release 2 on Ubuntu 14.04.1 LTS

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/sath89/oracle-xe-11g/) of [Docker Registry](https://registry.hub.docker.com/).

### Installation

    docker pull sath89/oracle-xe-11g

Run with 8080 and 1521 ports opened:

    docker run -d -p 8080:8080 -p 1521:1521 sath89/oracle-xe-11g

Run with data on host and reuse it:

    docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle sath89/oracle-xe-11g

Run with customization of processes, sessions, transactions
This customization is needed on the database initialization stage. If you are using mounted folder with DB files this is not used:

    ##Consider this formula before customizing:
    #processes=x
    #sessions=x*1.1+5
    #transactions=sessions*1.1
    docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle\
    -e processes=1000 \
    -e sessions=1105 \
    -e transactions=1215 \
    sath89/oracle-xe-11g

Connect database with following setting:

    hostname: localhost
    port: 1521
    sid: xe
    username: system
    password: oracle

Password for SYS & SYSTEM:

    oracle

Connect to Oracle Application Express web management console with following settings:

    http://localhost:8080/apex
    workspace: INTERNAL
    user: ADMIN
    password: oracle

**CHANGELOG**
* Fixed issue with reusable mounted data
* Fixed issue with ownership of mounted data folders
* Fixed issue with Gracefull shutdown of service
* Reduse size of image from 3.8G to 825Mb
* Database initialization moved out of the image build phase. Now database initializes at the containeer startup with no database files mounted
* Added database media reuse support outside of container
* Added graceful shutdown on containeer stop
* Removed sshd

