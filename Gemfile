source 'https://rubygems.org'

ruby '2.1.3'

# Padrino Stable Gem
gem 'padrino', '0.12.3'

# choose any db
# ex. If you want use mysql -> bundle install --without pg sqlite3
gem 'mysql2' , group: :mysql
gem 'pg'     , group: :postgres
gem 'sqlite3', group: :sqlite3

gem 'activerecord' , '~> 4.1.6', require: 'active_record'
gem 'activesupport', '~> 4.1.6', require: 'active_support'
gem 'annotate'
gem 'bcrypt'
gem 'foreman', '~> 0.75.0'
gem 'git'
gem 'global'
gem 'rake'
gem 'sass', '~> 3.4.5'
gem 'sidekiq'
gem 'slim'
gem 'unicorn'
gem 'yard'

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'faker'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec', "~> 3.1.0"
  gem 'rspec-json_matcher'
  gem 'rspec-padrino'
  gem 'rspec-parameterized'
  gem 'rspec-temp_dir', '0.0.3'
end

group :development do
  gem 'pry'    , group: :test
  gem 'pry-nav', group: :test
end
