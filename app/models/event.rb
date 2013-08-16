class Event < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :date, :description, :name, :time, :user_id, :city_id
  belongs_to :user
  belongs_to :city
end
