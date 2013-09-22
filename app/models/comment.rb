class Comment < ActiveRecord::Base
  attr_accessible :status_id, :text, :user_id

	belongs_to :status
	belongs_to :user
end
