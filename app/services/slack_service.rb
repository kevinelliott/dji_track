class SlackService

  class << self

    def generate_attachments(order)
      [
        {
          "fields": generate_fields(order)
    		},
        generate_shipping_status(order)
      ]
    end

    def generate_fields(order)
      [
        {
          "title": "Safe ID",
          "value": order.safe_id,
          "short": true
        },
        {
          "title": "Masked Order ID",
          "value": order.masked_order_id,
          "short": true
        },
        {
          "title": "Merchant",
          "value": order.merchant.common_name,
          "short": true
        },
        {
          "title": "Product",
          "value": order.product.name,
          "short": true
        },
        {
          "title": "Order Time",
          "value": order.order_time.presence || 'unknown',
          "short": true
        },
        {
          "title": "Country",
          "value": order.shipping_country.presence || 'unknown',
          "short": true
        }
      ]
    end

    def generate_shipping_status(order)
      shipping_status = case.shipping_status.try(:downcase)
      when 'shipped' then :shipped
      when 'canceled' then :canceled
      when 'pending', '', nil then :pending
      else
        :pending
      end

      case shipping_status
      when :shipped
        {
          "text": "This order has shipped.",
          "color": "good"
        }
      when :canceled
        {
          "text": "This order has been canceled.",
          "color": "danger"
        }
      when :pending
        {
          "text": "This order has not yet shipped."
        }
      end
    end

    def notify(options = {})
      channel = options[:channel]

      case options[:type]
      when :order_update
        SlackService.notify_order_update(channel: channel, order: options[:order])
      when :message
        SlackService.notify_message(channel: channel, message: options[:message])
      else
        puts "SlackService: Unknown :type provided '#{options[:type]}'."
      end
    end

    def notify_order_update(options = {})
      slack   = Slack::Web::Client.new
      channel = options[:channel]
      order   = options[:order]

      return nil if channel.blank? || order.blank?

      attachments = generate_attachments(order)

      puts "NotificationService: Posting order update notification to Slack."
      slack.chat_postMessage(
        channel: channel,
        text: 'Order Update',
        attachments: attachments,
        as_user: true,
        mrkdwn: true
      )
    end

    def notify_message(options = {})
      slack   = Slack::Web::Client.new
      channel = options[:channel]
      message = options[:message]

      return nil if channel.blank? || message.blank?

      puts "NotificationService: Posting message notification to Slack."
      slack.chat_postMessage(
        channel: channel,
        text: message,
        as_user: true,
        mrkdwn: true
      )
    end

  end

end