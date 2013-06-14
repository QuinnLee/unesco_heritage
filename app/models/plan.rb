class Plan < ActiveRecord::Base

  belongs_to :user
  attr_accessible :description, :name, :user_id
end
