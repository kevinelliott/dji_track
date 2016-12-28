class SlackService

  class << self

    def generate_attachments(order)
      attachments = [
        {
          "fields": generate_fields(order)
    		},
        generate_shipping_status(order)
      ]

      if order.shipped?
        attachments << generate_delivery_status(order)
      end

      attachments
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
          "value": order.product.try(:name).presence || 'unknown',
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

    def generate_delivery_status(order)
      delivery_status = case order.delivery_status.try(:downcase)
      when 'delivered' then :delivered
      when 'enroute' then :enroute
      when 'canceled' then :canceled
      when 'pending' then :pending
      else
        :pending
      end

      case delivery_status
      when :delivered
        {
          "text": "This order has been delivered.",
          "color": "good"
        }
      when :enroute
        {
          "text": "This order is en route and should be delivered soon.",
          "color": "warning"
        }
      when :canceled
        nil
      when :pending
        {
          "text": "This order has not yet arrived."
        }
      end
    end

    def generate_shipping_status(order)
      shipping_status = case order.shipping_status.try(:downcase)
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
      when :order_status
        SlackService.notify_order_status(channel: channel, order: options[:order])
      when :order_update
        SlackService.notify_order_update(channel: channel, order: options[:order])
      when :message
        SlackService.notify_message(channel: channel, message: options[:message])
      else
        puts "SlackService: Unknown :type provided '#{options[:type]}'."
      end
    end

    def notify_order_status(options = {})
      slack   = Slack::Web::Client.new
      channel = options[:channel]
      order   = options[:order]

      return nil if channel.blank? || order.blank?

      attachments = generate_attachments(order)

      puts "NotificationService: Posting order update notification to Slack."
      slack.chat_postMessage(
        channel: channel,
        text: 'Order Status',
        attachments: attachments,
        as_user: true,
        mrkdwn: true
      )
    end

    def notify_order_update(options = {})
      order   = options[:order]
      channel = options[:channel]

      message = "*#{order.safe_id}*: Order from *#{order.merchant.common_name}* of ID *#{order.masked_order_id.gsub("*", "X")}* for *#{order.product.name}* at #{order.order_time.presence || 'an unknown Order Time'} to *#{(order.shipping_country.presence || 'an unknown country').upcase}* was just shipped."
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
