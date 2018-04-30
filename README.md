docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 18.04 LTS

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/wnameless/oracle-xe-11g/) of [Docker Registry](https://registry.hub.docker.com/).

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

For XDB user, run this:
```
docker run -d -p 49161:1521 -p 8080:8080 -e ORACLE_ENABLE_XDB=true wnameless/oracle-xe-11g
```

Check if localhost:8080 work
```
curl -XGET "http://localhost:8080"
```
You will show
```
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<HTML><HEAD>
<TITLE>401 Unauthorized</TITLE>
</HEAD><BODY><H1>Unauthorized</H1>
</BODY></HTML>
```

```
# Login http://127.0.0.1:8080 with following credential:
username: XDB
password: xdb
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

Support custom DB Initialization
```
# Dockerfile
FROM wnameless/oracle-xe-11g

ADD init.sql /docker-entrypoint-initdb.d/
```
