class Ability
  include CanCan::Ability

  def initialize(user)
		user ||= User.new
		
		can [:read], User 
		can [:update, :destroy], User, :id => user.id
  end

  def initialize(event)
		user ||= User.new
		
		can [:read], Event 
		can [:update, :destroy], Event.user.id, :id => user.id
  end
end
