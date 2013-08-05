class Event < ActiveRecord::Base
	include PublicActivity::Common

  attr_accessible :name
end
