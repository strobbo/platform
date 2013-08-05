class ApplicationController < ActionController::Base
  protect_from_forgery

	include PublicActivity::StoreController

	def facebook_user
		@facebook_user ||= FbGraph::User.me(session["facebook_data"]["credentials"]["token"]).fetch
	end

	helper_method :facebook_user
end
