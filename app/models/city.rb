class City < ActiveRecord::Base
  attr_accessible :name, :capital, :state_id

	belongs_to :state
end
