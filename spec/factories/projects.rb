FactoryGirl.define do
  factory :project do
    name    { Faker::Internet.user_name  }
    branch  "master"
    ssh_url { "git@github.com:#{Faker::Internet.user_name}/#{Faker::Internet.user_name}.git" }
    commit  nil
  end
end
