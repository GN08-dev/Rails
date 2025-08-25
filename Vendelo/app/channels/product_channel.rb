class ProductChannel < ApplicationCable::Channel
  def subscribed
      # stream_from "some_channel"
      # stream_from "product_1068639269"
      stream_from "product_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
