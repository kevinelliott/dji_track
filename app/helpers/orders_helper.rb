module OrdersHelper

    def delivered_percent(orders)
      ((orders.delivered.count / orders.count.to_f) * 100).round
    end

    def shipped_percent(orders)
      ((orders.shipped.count / orders.count.to_f) * 100).round
    end

end
