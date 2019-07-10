_Note :_

The installation process and other tasks can be done via the Makefile commands. See [MAKE_HELP](MAKE_HELP.md) or with the `make help` command.

# INSTALL

``` sh
make install
```

__OR__

``` sh
cp _.env .env
docker-compose build
docker-compose run web bundle exec rake db:create
docker-compose run web bundle exec rake db:migrate
docker-compose run web rake secret
```

Set the output of the `rake secret` as the value of `SECRET_KEY_BASE` in your `.env` file.

_Option :_

To generate dummy data :



``` sh
make seed
```

__OR__

``` sh
docker-compose run web bundle exec rake db:seed
```

# RUN APP

``` sh
docker-compose up
```
