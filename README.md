docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 18.04 LTS

<del>This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/wnameless/oracle-xe-11g/) of [Docker Registry](https://registry.hub.docker.com/).</del>

Since 2019-Feb-13(the Valentine's day eve) this docker image has been removed by DockerHub due to the Docker DMCA Takedown Notice from the Copyright owner which is the Oracle.

Happy Valentine's day!

## Installation(with Ubuntu 18.04)
```
docker pull wnameless/oracle-xe-11g
```
SSH server has been removed since 18.04, please use "docker exec" or 16.04 instead.

## Installation(with Ubuntu 16.04)
```
docker pull wnameless/oracle-xe-11g:16.04
```

## Quick Start

Run with 1521 port opened:
```
docker run -d -p 49161:1521 wnameless/oracle-xe-11g
```

Run this, if you want the database to be connected remotely:
```
docker run -d -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true wnameless/oracle-xe-11g
```

For performance concern, you may want to disable the disk asynch IO:
```
docker run -d -p 49161:1521 -e ORACLE_DISABLE_ASYNCH_IO=true wnameless/oracle-xe-11g
```

Enable XDB user with default password: xdb, run this:
```
docker run -d -p 49161:1521 -e ORACLE_ENABLE_XDB=true wnameless/oracle-xe-11g
```

For APEX user:
```
docker run -d -p 49161:1521 -p 8080:8080 wnameless/oracle-xe-11g
```

```
# Login http://localhost:8080/apex/apex_admin with following credential:
username: ADMIN
password: admin
```

For latest APEX(18.1) user, please pull wnameless/oracle-xe-11g:18.04-apex first:
```
docker run -d -p 49161:1521 -p 8080:8080 wnameless/oracle-xe-11g:18.04-apex
```

```
# Login http://localhost:8080/apex/apex_admin with following credential:
username: ADMIN
password: Oracle_11g
```

By default, the password verification is disable(password never expired)<br/>
Connect database with following setting:
```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```

Password for SYS & SYSTEM
```
oracle
```

Support custom DB Initialization and running shell scripts
```
# Dockerfile
FROM wnameless/oracle-xe-11g

ADD init.sql /docker-entrypoint-initdb.d/
ADD script.sh /docker-entrypoint-initdb.d/
```
Running order is alphabetically. 
