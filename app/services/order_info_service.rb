class OrderInfoService

  def order_count(options = {})
    all_count      = Order.count
    canceled_count = Order.canceled.count

    default_counts = { all: all_count, canceled: canceled_count }

    case options[:filter]
    when :delivery_status
      delivered_count = Order.delivered.count
      enroute_count   = Order.enroute.count

      default_counts.merge(delivered: delivered_count, enroute: enroute_count)
    when :shipping_status
      not_shipped_count = Order.not_shipped.count
      shipped_count     = Order.shipped.count

      default_counts.merge(not_shipped: not_shipped_count, shipped: shipped_count)
    else
      default_counts
    end
  end

  def merchant_status_validation_request(order)
    if order.merchant.common_name == 'DJI'
      # Retrieve Order Tracking page to get captcha support
      tracking_page = DJI::OrderTracking.tracking_page

      # Store DJI state, set expiration, captcha image in database
      # request = order.validation_requests.create(...)

      request
    end
  end

  def merchant_status(validation_request, params = {})
    order = validation_request.order

    # Send captcha details along with form
    options = {
      order_number: order.order_id,
      phone_tail: order.phone_tail,
      captcha: params[:captcha],
      session: validation_request.session_id,
      debug: false
    }

    DJI::OrderTracking.tracking_details(options)
  end

end
