class NotificationService

  class << self

    def generate_attachments(order)
      [
        {
          "fields": generate_fields(order)
    		},
        {
            "text": "This order has shipped.",
            "color": "good"
        }
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

    def notify(options = {})
      return nil if options[:destinations].blank?

      options[:destinations].each do |destination|
        case destination[:medium]
        when :slack
          case options[:type]
          when :order_update
            notify_slack_order_update(channel: destination[:channel], order: options[:order])
          when :message
            notify_slack_message(channel: destination[:channel], message: options[:message])
          else
            puts "NotificationService: Unknown :type provided '#{options[:type]}'."
          end
        else
          puts "NotifcationService: Unknown :medium provided '#{destination[:medium]}' for destination."
        end
      end
    end

    def notify_slack_order_update(options = {})
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

    def notify_slack_message(options = {})
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