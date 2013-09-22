class Activity < PublicActivity::Activity

	# helper da gem 'unread'
	acts_as_readable :on => :updated_at

end
