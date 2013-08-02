class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :rememberable,
  # :lockable, :timeoutable and :omniauthable
  devise :trackable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
	attr_accessible :email, :encrypted_password, :provider, :uid, :name, :image, :location, 
									:profile_url, :image_url, :gender, :birthday

	# Relacionamentos nos quais este usuário segue outro usuário
	has_many :relationships, 
					 :class_name => "Relationship", :foreign_key => "follower_id", :dependent => :destroy
	has_many :followed_users, :through => :relationships, :source => :followed

	# Relacionamentos nos quais outro usuário segue este usuário
	has_many :reverse_relationships, 
					 :class_name => "Relationship", :foreign_key => "followed_id", :dependent => :destroy
	has_many :followers, :through => :reverse_relationships, :source => :follower

	def follow(user)
		self.relationships.build(:followed_id => user.id).save
	end

	def following?(user)
    relationships.find_by_followed_id(user.id)
  end

	def unfollow(user)
		self.relationships.find_by_followed_id(user.id).destroy
	end

	def followed?(user)
		self.reverse_relationships.find_by_follower_id(user.id)
	end

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
		user.update_attributes(	 
													 name: auth.extra.raw_info.name,
		                       provider: auth.provider,
		                       uid: auth.uid,
		                       email: auth.info.email,
													 profile_url: auth.info.urls.Facebook,
													 image_url: auth.info.image,
													 gender: auth.extra.raw_info.gender,
													 birthday: Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y').strftime('%Y-%m-%d'),
													 location: auth.info.location
		                      )
		user
	end

end
