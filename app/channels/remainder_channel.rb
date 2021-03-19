class RemainderChannel < ApplicationCable::Channel
  def subscribed
    stream_from "remainder_channel_79"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
