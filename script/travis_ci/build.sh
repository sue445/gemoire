#!/bin/bash -xe

# usage
# DATABASE=sqlite3 ./script/travis_ci/build.sh
# DATABASE=mysql ./script/travis_ci/build.sh
# DATABASE=postgresql ./script/travis_ci/build.sh

readonly DB_NAME="gemoire_test"

if [ "${DATABASE}" = "mysql" ]; then
  mysql -e "create database ${DB_NAME};"
elif [ "${DATABASE}" = "postgresql" ]; then
  psql -c "create database ${DB_NAME};" -U postgres
fi

cp ./config/global/gemoire.yml{.example,}
cp ./config/global/redis.yml{.example,}
cp ./script/travis_ci/database.yml.$DATABASE ./config/database.yml

RACK_ENV=test bundle exec rake ar:migrate:reset
bundle exec rspec --tag ~skip_on_ci
