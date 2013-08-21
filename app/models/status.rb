class Status < ActiveRecord::Base
  attr_accessible :event_id, :text, :user_id
  belongs_to :user
  belongs_to :event
end
