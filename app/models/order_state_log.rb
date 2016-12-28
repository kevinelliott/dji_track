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
      if options[:column] == 'shipping_status' &&
         options[:to].present? && 
         options[:to].downcase == 'shipped'
        
        order = options[:order]

        NotificationService.notify(
          type: :order_update,
          order: order,
          destinations: [
            { medium: :slack, channel: '#mavic-shipping-status' }
          ]
        )
      end
    end

  end

end
