FactoryGirl.define do
  factory :exam do
    user_id 1
    category_id {rand(4)}
    status "Start"
    started_time nil
  end
end
