class HaikuReactionsController < ApplicationController
  before_action :logged_in_user, only: %i[edit destroy]
  before_action :correct_post, only: :edit
  before_action :correct_user, only: :destroy

  def edit
    if current_user.likedComment?(@haiku.id)
        redirect_to request.referrer
    else
      @reaction = current_user.haiku_reactions.build(haiku_id: @haiku.id)
      if @reaction.save
        # flash[:success] = "liked successfuly!"
        unless current_user?(@reaction.haiku.user)
          @reaction_notification = @reaction.haiku.user.notifications.build(message: "#{current_user.name} reacted to your post",
                              notification_type: "haiku_reaction", haiku_reaction: @reaction, is_seen: false)
          @reaction_notification.save
        end
        
        redirect_to request.referrer
      else
        # flash[:danger] = "Invalid reaction"
        redirect_to request.referrer
      end
    end
  end

  def destroy
    @reaction.destroy
    # flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end

  private

  def correct_post
    @haiku = Haiku.find(params[:id])
    p "-=========================-==========------: #{@haiku}"
    redirect_to root_url if @haiku.nil?
  end

  def correct_user
    @reaction = current_user.haiku_reactions.find_by(id: params[:id])
    redirect_to root_url if @reaction.nil?
  end
end
