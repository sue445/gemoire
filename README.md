# Gemoire

[![wercker status](https://app.wercker.com/status/77a69cca299dd5e4b69c2c972beadcda/m "wercker status")](https://app.wercker.com/project/bykey/77a69cca299dd5e4b69c2c972beadcda)

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
