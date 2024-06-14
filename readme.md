# Docker for apiato

## About

Fast start apiato running one command

## Requirements

- docker
- docker compose
- make

## hosts

```
127.0.0.1 apiato.lc
127.0.0.1 api.apiato.lc
```

## Stop local services

Stop if running nginx or apache

```
sudo service nginx stop
sudo service apache2 stop
```

## Specify user and group id

```shell
# Get user id
$ id -u
1000

# Get group id
$ id -g
1000
```

If group and user id a both equal to 1000, don't need to do anything.
This is default value, already specified in `./docker/docker-compose.yml` file.

If group or user id is different from 1000, specify it in `./docker.env` file.
Create this file if it doesn't exist.

```dotenv
# ./docker/.env

USER_ID=<your-user-id>
GROUP_ID=<your-group-id>
```

## Build and start

```shell
cd docker && make init
```

After start, you should be able to access:

- [web welcome page](http://apiato.lc)
- [api welcome route](http://api.apiato.lc)

## Other commands

Stop running containers
```shell
$ make stop
```

Start containers again
```shell
$ make up
```

Build container after some changes in `./docker` directory
```shell
$ make build
```

Enter php container
```shell
$ make exec
# And run for example:
$ php artisan migrate:rollback
$ composer install
```


