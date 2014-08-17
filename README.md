# Gemoire

[![wercker status](https://app.wercker.com/status/77a69cca299dd5e4b69c2c972beadcda/m "wercker status")](https://app.wercker.com/project/bykey/77a69cca299dd5e4b69c2c972beadcda)

## Setup
```bash
bundle exec padrino rake ar:migrate
bundle exec padrino start
```

## Test
```bash
RACK_ENV=test bundle exec rake ar:migrate
bundle exec rspec
```
