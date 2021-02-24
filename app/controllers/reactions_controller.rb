class ReactionsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_post, only: :create
    before_action :correct_user, only: :destroy
    def create
        # @user = @reaction.user
		@reaction = current_user.reactions.build(micropost_id: @micropost.id)
		if @reaction.save
			# flash[:success] = "liked successfuly!"
			redirect_to request.referrer
		else
			@user = @micropost.user
			@microposts = @user.microposts.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
			# flash[:danger] = "Invalid reaction"
			redirect_to request.referrer 
		end
    end

    def destroy
        @reaction.destroy
        # flash[:success] = "comment deleted"
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
        def correct_user
            @reaction = current_user.reactions.find_by(id: params[:id])
            redirect_to root_url if @reaction.nil?
        end
end
