# H3A catalog project

Elixir language + Phoenix framework + Postgres database

## How to install

* Manual

```bash
$ git clone https://longyee@bitbucket.org/longyee/h3acatalog.git
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
$ git clone https://longyee@bitbucket.org/longyee/h3acatalog.git
$ cd h3acatalog/docker/web
$ docker build -t web .
$ cd ..
$ docker-compose up

$ docker-compose run web mix ecto.migrate
```

# h3acatalog
