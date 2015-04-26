# Postlite

A set of commands to manipulate a postfix sqlite database. Supports adding users,
domains and aliases and creating the DB schema.

## Install

  1. Clone the repository
  1. Run `./bin/postlite init >> ~/.bash_profile`
  1. Restart the shell
  1. Create `~/.postliterc` and add `POSTLITE_DB=/etc/postfix/postfix.db`
  1. Run postlite db init to create the database and schema

## Pre-requisites

### Sqlite

Sqlite3 command line client needs to be installed.

### Postfix maps

Postfix needs to be configured to use following virtual maps via `main.cf`:

sqlite-virtual-alias-maps.cf
``
dbpath = /etc/postfix/postfix.db
query = SELECT destination FROM virtual_aliases WHERE source='%s'
``

sqlite-virtual-mailbox-domains.cf
``
dbpath = /etc/postfix/postfix.db
query = SELECT 1 FROM virtual_domains WHERE name='%s'
``

sqlite-virtual-mailbox-maps.cf
``
dbpath = /etc/postfix/postfix.db
query = SELECT 1 FROM virtual_users WHERE email='%s'
``
### Dovecot

`doveadm pw` is used to hash/prompt for user passwords.

