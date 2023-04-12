# Docker Oracle XE

Oracle Express Edition 11g Release 2 on Ubuntu 18.04 LTS

## Installation(Local)

```bash
git clone https://github.com/wnameless/docker-oracle-xe-11g.git
cd docker-oracle-xe-11g
docker build -t wnameless/oracle-xe-11g .
docker images
docker run -d -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true --name oraclexe wnameless/oracle-xe-11g
```

## Installation(DockerHub)

```bash
docker pull wnameless/oracle-xe-11g-r2
```

For SSH server has been removed since 18.04, please use `docker exec`

## Oracle XE on Apple M chips

Currently, there is no Oracle Database port for ARM chips, hence Oracle XE images cannot run on the new Apple M chips via Docker Desktop.
Fortunately, there are other technologies that can spin up x86_64 software on Apple M chips, such as [colina](https://github.com/abiosoft/colima). To run these Oracle XE images on Apple M hardware, follow these simple steps:

* Install colima (instructions)
* Run colima start --arch x86_64 --memory 4
* Start container as usual

## Quick Start

Run with 1521 port opened:

```bash
docker run -d -p 49161:1521 wnameless/oracle-xe-11g-r2
```

Run this, if you want the database to be connected remotely:

```bash
docker run -d -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true wnameless/oracle-xe-11g-r2
```

For performance concern, you may want to disable the disk asynch IO:

```bash
docker run -d -p 49161:1521 -e ORACLE_DISABLE_ASYNCH_IO=true wnameless/oracle-xe-11g-r2
```

Enable XDB user with default password: xdb, run this:

```bash
docker run -d -p 49161:1521 -e ORACLE_ENABLE_XDB=true wnameless/oracle-xe-11g-r2
```

For APEX user:

```bash
docker run -d -p 49161:1521 -p 8080:8080 wnameless/oracle-xe-11g-r2
```

```bash
# Login http://localhost:8080/apex/apex_admin with following credential:
username: ADMIN
password: admin
```

For latest APEX(18.1) user, please pull wnameless/oracle-xe-11g-r2:18.04-apex first:

```bash
docker run -d -p 49161:1521 -p 8080:8080 wnameless/oracle-xe-11g-r2:18.04-apex
```

```bash
# Login http://localhost:8080/apex/apex_admin with following credential:
username: ADMIN
password: Oracle_11g
```

By default, the password verification is disable(password never expired)
Connect database with following setting

```bash
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```

Password for SYS & SYSTEM

```html
oracle
```

Support custom DB Initialization and running shell scripts

```Dockerfile
# Dockerfile
FROM wnameless/oracle-xe-11g-r2

ADD init.sql /docker-entrypoint-initdb.d/
ADD script.sh /docker-entrypoint-initdb.d/
```

Running order is alphabetically
