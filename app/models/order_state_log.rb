class OrderStateLog < ApplicationRecord
  belongs_to :order

  class << self

    def track_changes(order, changes)
      changes.each do |column, data|
        from, to = *data
        order.order_state_logs << OrderStateLog.new(column: column, from: from.try(:downcase), to: to.try(:downcase))
        order.save

        notify(order: order, column: column, from: from, to: to)
      end
    end


    def notify(options = {})
      if options[:column] == 'shipping_status' && options[:to].present? && options[:to].downcase == 'shipped'
        order   = options[:order]
        message = "_#{order.safe_id}_: Order with *#{order.merchant.common_name}* of ID *#{order.masked_order_id}* for *#{order.product.name}* on #{order.order_time.presence || 'an unknown Order Time'} to *#{(order.shipping_country.presence || 'an unknown country').upcase}* was just shipped."

        NotificationService.notify(
          message: message,
          destinations: [
            { medium: :slack, channel: '#mavic-shipping-status' }
          ]
        )
      end
    end

  end

end
