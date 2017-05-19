docker-oracle-xe-11g
============================
Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS. Fork by epiclabs

Credit to all the base work and contributors of wnameless/docker-oracle-xe-11g !!

## Main features of this fork:

* Volume support. Tweaks the configuration so you only have to mount an external empty directory to kick off your database.
* Removed SSH
* Graceful shutdown

### Installation(with Ubuntu 16.04)

```bash 
$ docker pull epiclabs/docker-oracle-xe-11g
```

Run with port 1521 opened:
```bash
$ docker run -d -p 1521:1521 epiclabs/docker-oracle-xe-11g
```

Volume support:

```bash
$ docker run -d -v /var/yourdata:/u01/app/oracle -p 1521:1521 epiclabs/docker-oracle-xe-11g
```

`/var/yourdata` is an empty directory which will be initialized as soon as the image runs for the first time. If the directory already contains data produced by a previous instance of this image, then the data is preserved. With this, the container can be thrown away every time.


Run like this, if you want the database to be connected remotely:

```bash
$ docker run -d -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true epiclabs/docker-oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```

Default password for SYS & SYSTEM
```
oracle
```

Support custom DB Initialization
```
# Dockerfile
FROM epiclabs/oracle-xe-11g

ADD init.sql /docker-entrypoint-initdb.d/
```

### Environment variables

* `ORACLE_PASSWORD` : Changes SYS and SYSTEM password to this value
* `RELAX_SECURITY` : If set to 1, a relaxed password policy profile will be put in place with this parameters for `SYS` and `SYSTEM` : 

```
CREATE PROFILE NOEXPIRY LIMIT
  COMPOSITE_LIMIT UNLIMITED
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_REUSE_TIME UNLIMITED
  PASSWORD_REUSE_MAX UNLIMITED
  PASSWORD_VERIFY_FUNCTION NULL
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  FAILED_LOGIN_ATTEMPTS UNLIMITED;
```

Example:

```bash
$ docker run -d -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true -e ORACLE_PASSWORD=testpassword -e RELAX_SECURITY=1 epiclabs/docker-oracle-xe-11g
```

