class ActivitiesController < ApplicationController
	before_filter :authenticate_user!
	after_filter :mark_as_read!, :only => :notifications

  def index
		@activities = Activity.order("created_at desc").where(:owner_id => current_user.followed_user_ids, owner_type: "User")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def notifications
		@activities = Activity.where(:owner_id => current_user.followed_user_ids, owner_type: "User").order("created_at desc").with_read_marks_for(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

	private
	def mark_as_read!
		@activities.mark_as_read! :all, :for => current_user
	end

end
