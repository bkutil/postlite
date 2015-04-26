# Postlite

A set of commands to manipulate a postfix sqlite database. Supports adding users,
domains and aliases and creating the DB schema.

## Install

1. Clone the repository

    ~~~ sh
    $ git clone https://github.com/bkutil/postlite.git ~/.postlite
    ~~~

2. Make sure `~/.postlite/bin` is in your `$PATH` (use `.bashrc` on Debian/Ubuntu and `.zshrc` for ZSH):

    ~~~ sh
    $ echo 'export PATH="$HOME/.postlite/bin:$PATH"' >> ~/.bash_profile
    ~~~

3. Add `postlite init` to your shell to enable autocompletion.

    ~~~ sh
    $ echo 'eval "$(postlite init -)"' >> ~/.bash_profile
    ~~~

4. Restart the shell

5. Create `~/.postliterc` and configure path to your Postfix sqlite DB:

    `POSTLITE_DB=/etc/postfix/postfix.db`

6. Run `postlite db init` to create the database and schema

## Pre-requisites

### Sqlite

Sqlite3 command line client needs to be installed.

### Dovecot

`doveadm pw` is used to hash/prompt for user passwords.

### Postfix maps

Postfix needs to be configured to use following virtual maps via `main.cf`:

sqlite-virtual-alias-maps.cf

    dbpath = /etc/postfix/postfix.db
    query = SELECT destination FROM virtual_aliases WHERE source='%s'


sqlite-virtual-mailbox-domains.cf

    dbpath = /etc/postfix/postfix.db
    query = SELECT 1 FROM virtual_domains WHERE name='%s'


sqlite-virtual-mailbox-maps.cf

    dbpath = /etc/postfix/postfix.db
    query = SELECT 1 FROM virtual_users WHERE email='%s'

### Dovecot SQL conf

Dovecot needs to be configured to use sqlite as it's backend and use this password query:

dovecot-sql.conf.ext

    driver = sqlite
    connect = /etc/postfix/postfix.db
    default_pass_scheme = SHA512-CRYPT
    password_query = \
      SELECT email as user, password \
        FROM virtual_users WHERE email = '%u'
