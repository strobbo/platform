class Status < ActiveRecord::Base
  attr_accessible :event_id, :text, :user_id
  belongs_to :user
  belongs_to :event
	has_many :comments

	validate :user_already_in_event

	private
	def user_already_in_event
		if self.event.participating?(self.user)
    	errors.add(:base, "Usuario ja inscrito no evento.")
		end
	end
end
