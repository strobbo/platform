class CommentsController < ApplicationController
	before_filter :authenticate_user!

  def create
		@comment = Comment.new
		@comment.user = User.find(params[:comment][:user_id])
		@comment.status = Status.find(params[:comment][:status_id])
		@comment.text = params[:comment][:text]

		respond_to do |format|
			if @comment.save
				format.html { redirect_to @comment.status }
			  format.js
			else
				format.html { redirect_to @comment.status, notice: :unprocessable}
		    format.json { render json: @comment.errors, comment: :unprocessable_entity }
		  end
		end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.status }
      format.json { head :no_content }
    end
  end
end
