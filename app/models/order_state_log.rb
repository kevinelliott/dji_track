class OrderStateLog < ApplicationRecord
  belongs_to :order

  class << self

    def track_changes(order, changes)
      changes.each do |column, data|
        from, to = *data
        order.order_state_logs << OrderStateLog.new(column: column, from: from.try(:downcase), to: to.try(:downcase))
        order.save
      end
    end

  end

end
