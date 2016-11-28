class OrderInfoService

  def order_count(options = {})
    all_count      = Order.count
    canceled_count = Order.canceled.count

    default_counts = { all: all_count, canceled: canceled_count }

    case options[:filter]
    when :delivery_status
      delivered_count = Order.delivered.count
      enroute_count   = Order.enroute.count

      default_counts.merge { delivered: delivered_count, enroute: enroute_count }
    when :shipping_status
      not_shipped_count = Order.not_shipped.count
      shipped_count     = Order.shipped.count

      default_counts.merge { not_shipped: not_shipped_count, shipped: shipped_count }
    else
      default_counts
    end
  end

end
