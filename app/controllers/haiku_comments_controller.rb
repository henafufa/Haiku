class HaikuCommentsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_post, only: :create
	before_action :correct_user, only: :destroy

	def create
			# @microposts = @user.microposts.paginate(page:params[:page])
		@user = @haiku.user
        verse_1 = params[:haiku_comment][:verse_1]
        verse_2 = params[:haiku_comment][:verse_2]
        verse_3 = params[:haiku_comment][:verse_3]
		@comment = current_user.haiku_comments.build(verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, haiku_id: @haiku.id)
		if @comment.save
			@comment_notification = @user.notifications.build(message: "#{@comment.user.name} commented on your post", 
											notification_type: "haiku_comment", haiku_comment: @comment, is_seen: false)
			flash[:success] = "comment posted!"
			@comment_notification.save
			redirect_to request.referrer || root_url
		else
			# @user = @haiku.user
			# @microposts = @user.microposts.paginate(page:params[:page])
			@microposts = @user.microposts.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
			flash[:danger] = "Invalid Haiku comment, comment should be follow a haiku format"
			redirect_to request.referrer || root_url
		end
	end

	def destroy
		@haiku_comment.destroy
		flash[:success] = "comment deleted"
		redirect_to request.referrer || root_url
	end

	private
		def comment_params
			params.require(:haiku_comment).permit(:verse_1, :verse_2, :verse_3, :haiku_id)
		end 

		def correct_post
			p "parmas #{params}"
			@haiku = Haiku.find(params[:haiku_id])
			redirect_to root_url if @haiku.nil?
		end

		def correct_user
			@haiku_comment = current_user.haiku_comments.find_by(id: params[:id])
			redirect_to root_url if @haiku_comment.nil?
		end 
end
