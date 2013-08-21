class Event < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :date, :description, :name, :time, :user_id, :city_id
  belongs_to :user
  belongs_to :city

	# Relacionamentos nos quais o evento possuis usuários com status
  has_many :statuses
  has_many :users, through: :statuses
end
