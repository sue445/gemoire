#!/bin/bash -xe

# usage
# DATABASE=sqlite3 ./script/circle_ci/build.sh
# DATABASE=mysql ./script/circle_ci/build.sh
# DATABASE=postgresql ./script/circle_ci/build.sh

bundle install --path vendor/bundle/
cp ./config/global/gemoire.yml{.example,}
cp ./config/global/redis.yml{.example,}
cp ./script/circle_ci/database.yml.$DATABASE config/database.yml
RACK_ENV=test bundle exec rake ar:migrate:reset
bundle exec rspec --tag ~skip_on_ci
