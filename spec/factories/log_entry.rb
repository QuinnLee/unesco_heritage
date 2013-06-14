require "faker"
FactoryGirl.define do
  factory :log_entry do
    user
    location
    first_date (Time.now - 1.week)
    last_date (Time.now - 1.day)
  end
end
