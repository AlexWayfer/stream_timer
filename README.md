# Stream Timer

## Tech stack

*   [**Flame** web framework](https://github.com/AlexWayfer/flame)
*   [**Sequel** ORM for relational databases](https://sequel.jeremyevans.net/)
*   [**Puma** web server](https://puma.io/)

-----

## Deployment

1.  Install [PostgreSQL](https://www.postgresql.org/).
2.  Install [`rbenv`](https://github.com/rbenv/rbenv).
3.  Install [`nodenv`](https://github.com/nodenv/nodenv).
4.  Set the [`EDITOR` environment variable][1] (`nano`, `vim`, `mcedit`, etc.).
5.  Clone this repository and checkout to directory.
6.  Run `exe/setup.sh` to install Ruby (with gems), Node.js (with modules) and fill configs.
7.  Run `toys db create_user` to create database user.
8.  Run `toys db create` to create database.
9.  Run `toys db migrate` to run database migrations.

[1]: https://en.wikibooks.org/wiki/Guide_to_Unix/Environment_Variables#EDITOR

### Production (optional)

*   Tune PostgreSQL (via [pgtune](https://pgtune.leopard.in.ua/), for example).
*   Set correct timezone.
*   Install `traceroute` (or `traceroute6`) for debug information in network errors reports.
*   Add UNIX-user for project: `adduser stream_timer`.
*   Install and configure `nginx` (with symbolic links from `config/nginx`).
*   Make symbolic link of project directory to `/var/www/stream_timer` (Debian),
    `/usr/share/nginx/stream_timer` (Fedora) or something  else,
    and change the root in `nginx` config.
    to something like `/home/stream_timer/stream_timer`.
*   Install [Certbot](https://certbot.eff.org/) and generate certificates.
    *   Optional `openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096`.
*   Copy `config/systemd.service` to the `~/.config/systemd/user/` directory and enable it.
    *   Don't forget to enable user services after logout: `loginctl enable-linger stream_timer`.

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

It will update default (or specified as first argument) branch,
update bundle, stop server, run migrations and start server.

### Remotely

```shell
toys deploy
```

It will run [`exe/update.sh` command](#locally) remotely
through `ssh` connection from `deploy.yaml` configuration file.

-----

## Update external resources

### [IcoMoon](https://icomoon.io/)

1.  Go to [IcoMoon App](https://icomoon.io/app/)
2.  Upload project
    1.  Click `Manage Projects` button
    2.  Click `Import Project` button
    3.  Upload `assets/icomoon/selection.json` file
    4.  Click `Load` button
3.  Modify the set of icons
    1.  Enter keyword (like `car` or `man`) into search field
    2.  Select desired icons
4.  Update icons
    1.  Click `Generate SVG & More` button
    2.  Check names and other settings
    3.  Click `Download` button
    4.  Run `toys icomoon extract %path_to_downloaded_archive%`
5.  Repeat these steps with the final `assets/icomoon/selection.json` file,
    because of there is a difference (in `setIdx` and `iconIdx` fields) between
    original `selection.json` file with freshly added icons and
    generated `selection.json` file with the same icons.
