docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/wnameless/oracle-xe-11g/) of [Docker Registry](https://registry.hub.docker.com/).

### Installation(with Ubuntu 16.04)
```
docker pull wnameless/oracle-xe-11g
```

### Installation(with older Ubuntu 14.04.4)
```
docker pull wnameless/oracle-xe-11g:14.04.4
```

Run with 22 and 1521 ports opened:
```
docker run -d -p 49160:22 -p 49161:1521 wnameless/oracle-xe-11g
```

Run this, if you want the database to be connected remotely:
```
docker run -d -p 49160:22 -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true wnameless/oracle-xe-11g
```

By default, the passeord verification is disable(password never expired). If you want it back, run this:
```
docker run -d -p 49160:22 -p 49161:1521 -e ORACLE_PASSWORD_VERIFY=true wnameless/oracle-xe-11g
```

For performance concern, you may want to disable the disk asynch IO:
```
docker run -d -p 49160:22 -p 49161:1521 -e ORACLE_DISABLE_ASYNCH_IO=true wnameless/oracle-xe-11g
```

For XDB user, run this:
```
docker run -d -p 49160:22 -p 49161:1521 -e ORACLE_ENABLE_XDB=true wnameless/oracle-xe-11g
```
```
# Login http://localhost:8080 with following credential:
username: XDB
password: xdb
```

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

Login by SSH
```
ssh root@localhost -p 49160
password: admin
```

Support custom DB Initialization
```
# Dockerfile
FROM wnameless/oracle-xe-11g

ADD init.sql /docker-entrypoint-initdb.d/
```
