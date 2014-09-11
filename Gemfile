source 'https://rubygems.org'

ruby '2.1.2'

gem 'padrino', '0.12.3'

gem 'activerecord' , '~> 4.1.4', require: 'active_record'
gem 'activesupport', '~> 4.1.4', require: 'active_support'
gem 'annotate'
gem 'bcrypt'
gem 'foreman'
gem 'git'
gem 'global'
gem 'rake'
gem 'sass'
gem 'slim'
gem 'unicorn'
gem 'yard'

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'faker'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec', "~> 3.0.0"
  gem 'rspec-padrino'
  gem 'rspec-temp_dir', '0.0.3'
end

group :development do
  gem 'pry'    , group: :test
  gem 'pry-nav', group: :test
  gem 'sqlite3', group: :test
end

group :production do
  gem 'pg', group: :postgres
end

