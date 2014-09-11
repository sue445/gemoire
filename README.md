# Gemoire

[![Circle CI](https://circleci.com/gh/sue445/gemoire/tree/master.png?style=badge)](https://circleci.com/gh/sue445/gemoire/tree/master)

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
