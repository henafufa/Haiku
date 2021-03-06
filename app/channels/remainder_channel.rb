class RemainderChannel < ApplicationCable::Channel
  def subscribed
    stream_from "remainder_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
