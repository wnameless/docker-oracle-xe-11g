docker-oracle-xe-11g-soa
========================

_Forked from https://github.com/wnameless/docker-oracle-xe-11g_

Oracle Express Edition 11g Release 2 on Ubuntu 14.04.1 LTS

# Installation
```
git clone https://github.com/plmwong/docker-oracle-xe-11g-soa.git
docker build -t paybyphone/soa docker-oracle-xe-11g-soa
```
### Run container with 22 and 1521 ports opened:
```
docker run -d -p 49160:22 -p 49161:1521 paybyphone/soa
```
### Connect to database:
```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```

Example tnsnames.ora entry:
```
loki = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 49161)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = xe)))
```

### Password for SYS & SYSTEM
```
oracle
```

### Login via SSH
```
ssh root@localhost -p 49160
password: admin
```
