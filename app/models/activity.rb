class Activity < PublicActivity::Activity

	# helper da gem 'unread'
	acts_as_readable :on => :created_at

end
