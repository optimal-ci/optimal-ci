FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    token { Faker::Crypto.sha256 }
  end
end
