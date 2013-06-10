class Location < ActiveRecord::Base
  has_many :log_entries
  has_many :users, :through =>:log_entries
  attr_accessible :name
end
