class HaikusController < ApplicationController
    include HaikusHelper
    before_action :logged_in_user, only: [:create, :destroy, :update]
    before_action :correct_user, only: [:destroy, :update]

    def create
        verse_1 = params[:haiku][:verse_1]
        verse_2 = params[:haiku][:verse_2]
        verse_3 = params[:haiku][:verse_3]
        tag = params[:haiku][:tag]
        bgcolor = params[:haiku][:bgcolor]
        if(params[:post_button] == "Post")
            is_public = true
            if params[:visibility] && params[:visibility] === 'Private'
                is_public = false
            end
            
            @haiku = current_user.haikus.build(verse_1: verse_1, verse_2: verse_2, verse_3: verse_3,tag: tag, public: is_public, bgcolor: bgcolor)        
            @haiku.image.attach(params[:haiku][:image])
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
        elsif(params[:post_button] == "Finish")
            is_public = true
            if params[:visibility] && params[:visibility] === 'Private'
                is_public = false
            end

            @haiku = current_user.haikus.build(verse_1: params[:haiku_verse_1], verse_2: params[:haiku_verse_2], verse_3: verse_3,tag: tag, public: is_public)        
            @haiku.image.attach(params[:haiku][:image])

            if @haiku.save
                flash[:success] = "Haiku created!"
                challenge_user = ChallengeUser.find_by(challenge_id: params[:challenge_id], user_id: current_user.id)
                if(challenge_user)
                    challenge_user.destroy
                end
                redirect_to challenges_path
            else
                @comment = Comment.new
                @haiku_comment = HaikuComment.new
                @micropost = Micropost.new

                @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
                # @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
                @haiku_feed_items = Haiku.where("public = ?", true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
                render 'static_pages/home'
            end

        else
            @challenge = current_user.challenges.build(verse_1: verse_1, verse_2: verse_2)
            if @challenge.save
                redirect_to challenge_user_path
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
    end
    def update
        if !@haiku.public?
            @haiku.update(public: true)
            redirect_to request.referrer || root_url
        else
            redirect_to request.referrer || root_url
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
            params.require(:haiku).permit(:verse_1, :verse_2, :verse_3, :tag, :visibility, :image, :bgcolor)
        end
        def correct_user
            @haiku = current_user.haikus.find_by(id: params[:id])
            redirect_to root_url if @haiku.nil?
        end
        def challenge_params
            params.require(:haiku).permit(:verse_1, :verse_2)
        end
end
