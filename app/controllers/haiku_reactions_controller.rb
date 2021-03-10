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
