# $ rails generate channel products
#
# Channels can have security implications, so by default Rails only allows
# access from the localhost when running in development mode. If you’re doing
# development with multiple machines, you must disable this check. Do this by
# adding the following line to config/environments/development.rb:
#
# config.action_cable.disable_request_forgery_protection = true
#
#
# We’ll be sending only data over this channel, and not processing commands,
# so this is safe to do.


class ProductsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "products"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
