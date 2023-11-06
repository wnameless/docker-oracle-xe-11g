docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 18.04 LTS


## Installation
```
git clone https://github.com/interob/docker-oracle-xe-11g.git
cd docker-oracle-xe-11g
docker build -t interob/oracle-xe-11g .
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

For performance concern, you may want to disable the disk asynch IO:
```
docker run -d -p 49161:1521 -e ORACLE_DISABLE_ASYNCH_IO=true interob/oracle-xe-11g-r2
```

Enable XDB user with default password: xdb, run this:
```
docker run -d -p 49161:1521 -e ORACLE_ENABLE_XDB=true interob/oracle-xe-11g-r2
```

For APEX user:
```
docker run -d -p 49161:1521 -p 8080:8080 interob/oracle-xe-11g-r2
```

```
# Login http://localhost:8080/apex/apex_admin with following credential:
username: ADMIN
password: admin
```

For latest APEX(18.1) user, please pull interob/oracle-xe-11g-r2:18.04-apex first:
```
docker run -d -p 49161:1521 -p 8080:8080 interob/oracle-xe-11g-r2:18.04-apex
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

Default password for SYS & SYSTEM
```
oracle
```

Support custom DB Initialization and running shell scripts
```
# Dockerfile
FROM interob/oracle-xe-11g

ADD init.sql /docker-entrypoint-initdb.d/
ADD script.sh /docker-entrypoint-initdb.d/
```
Running order is alphabetically. 

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
$ docker run -d -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true -e ORACLE_PASSWORD=testpassword -e RELAX_SECURITY=1 interob/docker-oracle-xe-11g
```

