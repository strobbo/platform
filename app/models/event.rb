class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :name, :time, :user_id
  belongs_to :user
end
