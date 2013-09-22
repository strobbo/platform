class StatusesController < ApplicationController
	before_filter :authenticate_user!

  def create
		@status = Status.new
		@status.user = User.find(params[:status][:user_id])
		@status.event = Event.find(params[:status][:event_id])
		@status.text = params[:status][:text]

		respond_to do |format|
			if @status.save
				format.html { redirect_to @status.event }
			  format.js
			else
				format.html { redirect_to @status.event, notice: :unprocessable}
		    format.json { render json: @status.errors, status: :unprocessable_entity }
		  end
		end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to @status.event }
      format.json { head :no_content }
    end
  end
end
