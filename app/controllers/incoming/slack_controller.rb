class Incoming::SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    channel  = "##{params[:channel_name]}"
    incoming = params[:text].split(' ')[1..-1].join(' ')
    context, context_param, *command = incoming.split(' ')

    case context
    when 'order'
      safe_id = context_param

      if safe_id.present?
        order = Order.where(safe_id: safe_id.downcase)

        if order.present?
          case command
          when 'status'
            SlackService.notify(type: :order_update, order: order, channel: channel)
          else
            message = "There is no order command called '#{command}'. Try: status"
            SlackService.notify_message(channel: channel, message: message)
          end
        else
          message = "There is no order for the Safe ID of '#{safe_id}'."
          SlackService.notify_message(channel: channel, message: message)
        end
      else
        message = "You must provide a Safe ID to look up an order."
        SlackService.notify_message(channel: channel, message: message)
      end
    else
      message = "I don't know what '#{context}' means yet."
      SlackService.notify_message(channel: channel, message: message)
    end
  end

end
