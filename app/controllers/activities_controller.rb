class ActivitiesController < ApplicationController
	before_filter :authenticate_user!

  def index
		@activities = PublicActivity::Activity.order("created_at desc").where(:owner_id => current_user.followed_user_ids, owner_type: "User")
  end

end
