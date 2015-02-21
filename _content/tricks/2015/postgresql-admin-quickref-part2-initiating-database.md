# PostgesSQL 9 Administration QuickRef(2) - Managing Database

- date: 2015-02-21 16:40
- tags: postgresql, database
- category: tricks

----------------------------

### 1. Creating a Database

It's a common task to create a database and assign an access user for it. This can be done by command line or by psql queries.

```bash

# by command line
$ su postgres
$ createuser -D -A -P myuser
$ createdb -O myuser mydb

# (or) a longer version for the createdb command
$ createdb -h localhost -p 5432 -U postgres -O myuser -E UTF8 mydb

```

```psql

--create database by psql client 
postgres=# CREATE USER myuser WITH PASSWORD 'my_password';
postgres=# CREATE DATABASE mydb WITH OWNER myuser ENCODING 'UTF8';
postgres=# GRANT ALL PRIVILEGES ON DATABASE "mydb" to myuser;

```

### 2. Configuring Connection Method

Peer authentication uses system's user accounts for authentication, while MD5 authentication uses password authentication encrypted in md5.

Restart Postgresql service after configuration file is changed.

```bash

# Edit the file for the database access method
$ sudo vi /etc/postgresql/9.1/main/pg_hba.conf

# Database administrative login by Unix domain socket
local   all             postgres                                peer

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
#host    replication     postgres        127.0.0.1/32            md5
#host    replication     postgres        ::1/128                 md5


$ sudo service postgresql restart

```
