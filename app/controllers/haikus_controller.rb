class HaikusController < ApplicationController

    def create
        @haiku = current_user.haikus.build(haiku_params)
        
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @comment = Comment.new
            # @feed_items = current_user.feed.paginate(page: params[:page])
            @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            render 'static_pages/home'
        end
    end
end
