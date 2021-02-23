class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_post, only: :create

	def create
			# @microposts = @user.microposts.paginate(page:params[:page])
		@user = @micropost.user
		@comment = current_user.comments.build(content: params[:comment][:content],micropost_id: @micropost.id)
		if @comment.save
			flash[:success] = "comment posted!"
			redirect_to request.referrer 
		else
			@user = @micropost.user
			@microposts = @user.microposts.paginate(page:params[:page])
			flash[:danger] = "Invalid comment"
			redirect_to request.referrer 
		end
	end
	def destroy
			# @comment.destroy
		flash[:success] = "comment deleted"
		redirect_to request.referrer || root_url
	end

	private
		def micropost_params
			params.require(:comment).permit(:content, :micropost_id)
		end 

		def correct_post
			@micropost = Micropost.find(params[:micropost_id])
			redirect_to root_url if @micropost.nil?
		end

	# def correct_user
	#     @comment = current_user.comments.find_by(id: params[:micropost_id])
	#     redirect_to root_url if @comment.nil?
	# end
			
end
