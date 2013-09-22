class Event < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :date, :description, :name, :time, :user_id, :city_id
  belongs_to :user
  belongs_to :city

	# Relacionamentos nos quais o evento possuis usuários com status
  has_many :statuses
  has_many :users, through: :statuses

	def number_of_followers(user)
		self.statuses.joins("INNER JOIN (SELECT follower_id FROM relationships WHERE followed_id = #{user.id}) AS followers ON followers.follower_id = statuses.user_id").where("event_id = #{self.id}").count
	end

	def number_of_followeds(user)
		self.statuses.joins("INNER JOIN (SELECT followed_id FROM relationships WHERE follower_id = #{user.id}) AS followeds ON followeds.followed_id = statuses.user_id").where("event_id = #{self.id}").count
	end
end
