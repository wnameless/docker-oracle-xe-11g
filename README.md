docker-oracle-xe-11g
============================
Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS. Fork by epiclabs

Oracle Express Edition 11g Release 2 on Ubuntu 18.04 LTS

<del>This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/wnameless/oracle-xe-11g/) of [Docker Registry](https://registry.hub.docker.com/).</del>

<del>Since 2019-Feb-13(the Valentine's day eve) this docker image has been removed by DockerHub due to the Docker DMCA Takedown Notice from the Copyright owner which is the Oracle.</del>

<del>Happy Valentine's day!</del>

```diff
+ The new DockerHub [wnameless/oracle-xe-11g-r2] has been released, because
+ the old [wnameless/oracle-xe-11g] is banned by DockerHub and I cannot restore it.
+ Thanks for the help from the staff in Oracle with my DMCA Takedown issue, however this problem
+ is totally ignored by the DockerHub and I barely can't do anything but to open a new repo.
+ Sep 29 2019
```

## Installation(Local)
```
git clone https://github.com/wnameless/docker-oracle-xe-11g.git
cd docker-oracle-xe-11g
docker build -t wnameless/oracle-xe-11g .
```

## Installation(DockerHub)
```
docker pull wnameless/oracle-xe-11g-r2
```
SSH server has been removed since 18.04, please use "docker exec"

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
docker run -d -p 49161:1521 -e ORACLE_DISABLE_ASYNCH_IO=true wnameless/oracle-xe-11g-r2
```

Enable XDB user with default password: xdb, run this:
```
docker run -d -p 49161:1521 -e ORACLE_ENABLE_XDB=true wnameless/oracle-xe-11g-r2
```

For APEX user:
```
docker run -d -p 49161:1521 -p 8080:8080 wnameless/oracle-xe-11g-r2
```

```
# Login http://localhost:8080/apex/apex_admin with following credential:
username: ADMIN
password: admin
```

For latest APEX(18.1) user, please pull wnameless/oracle-xe-11g-r2:18.04-apex first:
```
docker run -d -p 49161:1521 -p 8080:8080 wnameless/oracle-xe-11g-r2:18.04-apex
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
FROM epiclabs/oracle-xe-11g

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
$ docker run -d -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true -e ORACLE_PASSWORD=testpassword -e RELAX_SECURITY=1 epiclabs/docker-oracle-xe-11g
```

