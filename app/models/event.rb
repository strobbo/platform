class Event < ActiveRecord::Base
	include PublicActivity::Common

  attr_accessible :date, :description, :location, :name, :time, :user_id
  belongs_to :user
end
