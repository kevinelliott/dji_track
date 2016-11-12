class OrderStateLog < ApplicationRecord
  belongs_to :order

  class << self

    def track_changes(order, changes)
      changes.each do |column, data|
        from, to = *data
        order.order_state_logs << OrderStateLog.new(column: column, from: from.try(:downcase), to: to.try(:downcase))
        order.save

        notify_slack(order, column, from, to)
      end
    end

    def notify_slack(order, column, from, to)
      if column == 'shipping_status' && to.present? && to.downcase == 'shipped'
        message = "#{order.merchant.common_name}: Order #{order.masked_order_id} for #{order.product.name} on #{order.order_time.presence || 'an unknown Order Time'} to #{(order.shipping_country.presence || 'UNKNOWN').upcase} was just shipped."

        slack = Slack::Web::Client.new
        slack.chat_postMessage(
          channel: '#mavic-shipping-status',
          text: message,
          as_user: true
        )
      end
    end

  end

end
