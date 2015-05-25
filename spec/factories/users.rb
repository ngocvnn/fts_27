FactoryGirl.define do
  factory :user do
    name "Example"
    sequence(:email){|n| "example-#{n}@railstutorial.com"}
    password "12345678"
    password_confirmation {password}
    role 0
  end
end
