require "faker"
FactoryGirl.define do
  factory :log_entry do
    user
    location
    first_date (Time.now - 1.week).to_date
    last_date (Time.now - 1.day).to_date
  end
end
