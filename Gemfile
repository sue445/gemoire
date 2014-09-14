source 'https://rubygems.org'

ruby '2.1.2'

gem 'padrino', '0.12.3'

gem 'activerecord' , '~> 4.1.6', require: 'active_record'
gem 'activesupport', '~> 4.1.6', require: 'active_support'
gem 'annotate'
gem 'bcrypt'
gem 'foreman', '~> 0.75.0'
gem 'git'
gem 'global'
gem 'mysql2', group: :mysql
gem 'pg', group: :postgres
gem 'rake'
gem 'sass', '~> 3.4.4'
gem 'slim'
gem 'sqlite3', group: :sqlite3
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
  gem 'rspec-padrino'
  gem 'rspec-temp_dir', '0.0.3'
end

group :development do
  gem 'pry'    , group: :test
  gem 'pry-nav', group: :test
end
