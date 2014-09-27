# Gemoire
Gemoire (Gem + grimoire) is [YARD](http://yardoc.org/) hosting app, like [RubyDoc.info](http://rubydoc.info/)

[![Circle CI](https://circleci.com/gh/sue445/gemoire/tree/master.png?style=badge)](https://circleci.com/gh/sue445/gemoire/tree/master)
[![Dependency Status](https://gemnasium.com/sue445/gemoire.svg)](https://gemnasium.com/sue445/gemoire)
[![Code Climate](https://codeclimate.com/github/sue445/gemoire/badges/gpa.svg)](https://codeclimate.com/github/sue445/gemoire)
[![Coverage Status](https://img.shields.io/coveralls/sue445/gemoire.svg)](https://coveralls.io/r/sue445/gemoire?branch=master)

[![Stories in Ready](https://badge.waffle.io/sue445/gemoire.svg?label=ready&title=Ready)](http://waffle.io/sue445/gemoire)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Features
* clone/fetch git repository
* generate and browse yard document
* webhooks
  * Github :octocat:
  * Bitbucket
  * Gitlab

## Requirements
* Ruby 2.1.3
* some DBs: MySQL, PostgreSQL or sqlite3
* git 1.6+
* redis

## Setup
```bash
cp config/global/gemoire.yml{.example,}
cp config/global/redis.yml{.example,}
vi config/global/gemoire.yml
vi config/global/redis.yml

#####
cp config/database.yml{.sqlite3,}
# or
cp config/database.yml{.mysql,}
# or
cp config/database.yml{.postgresql,}
#####

vi config/database.yml

bundle exec padrino rake ar:create ar:migrate

# setup admin user/pass
bundle exec rake db:seed
```

## Run development
```bash
bundle exec padrino start
bundle exec sidekiq -r ./config/sidekiq.rb
# or
bundle exec foreman start
```

## Test
```bash
RACK_ENV=test bundle exec rake ar:migrate
bundle exec rspec
```

## Sandbox
http://gemoire.herokuapp.com/

## for Heroku
```bash
vi config/global/gemoire.yml.heroku
vi config/global/redis.yml.heroku
```

### :warning: Caution
* generated document and cloned repository are cleared each deploy
* can not use `ssh://` at `remote_url`

## more documents
* [deploy key](doc/deploy_key.md)
* [webhook](doc/webhook.md)

