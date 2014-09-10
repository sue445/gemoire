FactoryGirl.define do
  factory :project do
    name           { Faker::Internet.user_name  }
    branch         "master"
    remote_url     { "git@github.com:#{Faker::Internet.user_name}/#{Faker::Internet.user_name}.git" }
    repository_url { Faker::Internet.url  }
    commit         nil
  end
end
