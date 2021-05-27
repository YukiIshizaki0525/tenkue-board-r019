FactoryBot.define do
  factory :user, class: User do
    name { 'alice' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "v4xqUvAXhK" }
    password_confirmation { "v4xqUvAXhK" }
     
  end
end

