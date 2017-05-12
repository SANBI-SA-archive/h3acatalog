# H3A catalog project

Elixir language + Phoenix framework + Postgres database

## How to install

* Manual

```bash
$ git clone https://github.com/SANBI-SA/h3acatalog.git
$ cd h3acatalog
$ mix deps.get
$ vi config/dev.exs
$ mix ecto.create
$ mix ecto.migrate
$ npm install
$ mix phoenix.server
```
* Docker

```bash
$ git clone https://github.com/SANBI-SA/h3acatalog.git
$ cd h3acatalog/docker/
$ docker-compose up -d
$ docker-compose run web mix ecto.migrate
```
