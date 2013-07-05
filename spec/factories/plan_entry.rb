require "faker"
FactoryGirl.define do
  factory :plan_entry do
    plan
    location
  end
end
