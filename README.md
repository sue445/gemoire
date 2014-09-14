# Gemoire

[![Circle CI](https://circleci.com/gh/sue445/gemoire/tree/master.png?style=badge)](https://circleci.com/gh/sue445/gemoire/tree/master)
[![Dependency Status](https://gemnasium.com/sue445/gemoire.svg)](https://gemnasium.com/sue445/gemoire)
[![Code Climate](https://codeclimate.com/github/sue445/gemoire/badges/gpa.svg)](https://codeclimate.com/github/sue445/gemoire)
[![Test Coverage](https://codeclimate.com/github/sue445/gemoire/badges/coverage.svg)](https://codeclimate.com/github/sue445/gemoire)

[![Stories in Ready](https://badge.waffle.io/sue445/gemoire.svg?label=ready&title=Ready)](http://waffle.io/sue445/gemoire)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Requirements
* Ruby 2.1.2
* git 1.6+

## Setup
```bash
cp config/global/gemoire.yml{.example,}
vi config/global/gemoire.yml

#####
cp config/database.yml{.sqlite3,}
# or
cp config/database.yml{.mysql,}
# or
cp config/database.yml{.postgresql,}
#####

vi config/database.yml

bundle exec padrino rake ar:migrate
```

## Run development
```bash
bundle exec padrino start
# or
bundle exec foreman start
```

## Test
```bash
RACK_ENV=test bundle exec rake ar:migrate
bundle exec rspec
```
