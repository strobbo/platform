class Ability
  include CanCan::Ability

  def initialize(user)
		user ||= User.new

		# permissões para usuários interagindo com usuários		
		can [:read], User 
		can [:update, :destroy], User, :id => user.id

		# permissões para usuários interagindo com eventos
		can [:read, :create], Event 
		can [:update, :destroy], Event, :user_id => user.id

		# permissões para usuários interagindo com status
		can [:read, :create], Status 
		can [:destroy], Status, :user_id => user.id

		# permissões para usuários interagindo com comentários
		can [:read, :create], Comment
		can [:destroy], Comment, :user_id => user.id
  end
end
