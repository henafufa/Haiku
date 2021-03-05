class HaikusController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        verse_1 = params[:haiku][:verse_1]
        verse_2 = params[:haiku][:verse_2]
        verse_3 = params[:haiku][:verse_3]
        is_public = true
        if params[:visibility] && params[:visibility] === 'Private'
            is_public = false
        end

        @haiku = current_user.haikus.build(verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, public: is_public)        
        if @haiku.save
            flash[:success] = "Haiku created!"
            redirect_to root_url
        else
            @comment = Comment.new
            @haiku_comment = HaikuComment.new
            @micropost = Micropost.new

            @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            # @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            @haiku_feed_items = Haiku.where("public = ?", true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            render 'static_pages/home'
        end
    end

    def show
        @haiku_comment = HaikuComment.new
        @haiku = Haiku.find(params[:id])
    end

    def destroy
        @haiku.destroy
        flash[:success] = "Haiku deleted"
        redirect_to request.referrer || root_url
    end

    private
        def haiku_params
            params.require(:haiku).permit(:verse_1, :verse_2, :verse_3, :visibility)
        end
        def correct_user
            @haiku = current_user.haikus.find_by(id: params[:id])
            redirect_to root_url if @haiku.nil?
        end
end
