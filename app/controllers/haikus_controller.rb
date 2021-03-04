class HaikusController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @haiku = current_user.haikus.build(haiku_params)        
        if @haiku.save
            flash[:success] = "Haiku created!"
            redirect_to root_url
        else
            @comment = Comment.new
            @micropost = Micropost.new

            @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            render 'static_pages/home'
        end
    end

     def destroy
        @haiku.destroy
        flash[:success] = "Haiku deleted"
        redirect_to request.referrer || root_url
    end

    private
        def haiku_params
            params.require(:haiku).permit(:verse_1, :verse_2, :verse_3)
        end
        def correct_user
            @haiku = current_user.haikus.find_by(id: params[:id])
            redirect_to root_url if @haiku.nil?
        end
end
