require 'faker'

FactoryGirl.define do
  factory :goal do
    goal_name { Faker::Name.name }
    user_id 1
    completed false
    priv false
  end
end
