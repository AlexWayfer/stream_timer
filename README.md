# Stream Timer

## Tech stack

*   [**Flame** web framework](https://github.com/AlexWayfer/flame)
*   [**Sequel** ORM for relational databases](https://sequel.jeremyevans.net/)
*   [**Puma** web server](https://puma.io/)

-----

## Deployment

1.  Install [PostgreSQL](https://www.postgresql.org/).
2.  Database setup
    1.  Create a project user:
        `createuser -U postgres stream_timer`
        (with `-P` for network-open databases)
3.  Install [`rbenv`](https://github.com/rbenv/rbenv).
4.  Install [`nodenv`](https://github.com/nodenv/nodenv).
5.  Set the [`EDITOR` environment variable][1] (`nano`, `vim`, `mcedit`, etc.).
6.  Clone this repository and checkout to directory.
7.  Run `exe/setup.sh` to install Ruby (with gems) and fill configs.
8.  Run `toys db create` to create database.
9.  Run `toys db migrate` to run database migrations.

[1]: https://en.wikibooks.org/wiki/Guide_to_Unix/Environment_Variables#EDITOR

### Production (optional)

*   Tune PostgreSQL (via [pgtune](https://pgtune.leopard.in.ua/), for example).
*   Set correct timezone.
*   Add UNIX-user for project: `adduser stream_timer`.
*   Make symbolic link of project directory to `/var/www/stream_timer` (Debian),
    `/usr/share/nginx/stream_timer` (Fedora) or something  else,
    and change the root in `nginx` config.
    to something like `/home/stream_timer/stream_timer`.
*   Install and configure `nginx` (with symbolic links from `config/nginx`).
*   Install [Certbot](https://certbot.eff.org/) and generate certificates.
    *   Optional `openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096`.
*   Install `traceroute` (or `traceroute6`) for debug information in network errors reports.

-----

## Tools

### Server management

For management server state use `toys server` command.

### Ruby console

Realized with [`pry`](https://github.com/pry/pry):

```shell
toys console
```

(All models and other classes are available)

### PostgreSQL console

```shell
toys psql
```

(For login as `postgres` user use `sudo su - postgres`)

-----

## Database migrations

### Create migration

```shell
toys db migrations new migration_name
```

### List migrations

```shell
toys db migrations
# toys db migrations list
```

### Run migrations

To latest:

```shell
toys db migrate
# toys db migrations run
```

To specific version (forward or backward):

```shell
toys db migrate --target=part_of_target_migration_name_or_version
```

### Rollback migrations

`N` is a number of migrations to rollback relatively to the latest existing.

```shell
toys db migrations rollback N
```

-----

## Update server

### Locally

```shell
exe/update.sh
```

It will update `master` branch, update bundle, stop server, run migrations
and start server.

### Remotely

```shell
toys deploy
```

It will run [`exe/update.sh` command](#locally) remotely
through `ssh` connection from `deploy.yaml` configuration file.
