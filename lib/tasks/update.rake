namespace :update do

  task order_status: :environment do
    puts "Updating DJI Order Statuses"
    puts "-------------------------------------------------------------------"
    puts

    orders = Order.order(updated_at: :asc).limit(10)

    orders.each_with_index do |order, index|
      count        = index + 1
      debug_prefix = "#{count} - Order #{order.order_id}/#{order.phone_tail}"

      if order.order_id.present? && order.phone_tail.present?
        options = { order_number: order.order_id, phone_tail: order.phone_tail, debug: false }
        data    = DJI::OrderTracking.tracking_details(options)

        if data.present?
          order.payment_total    = data[:total]
          order.shipping_status  = data[:shipping_status]
          order.shipping_company = data[:shipping_company]
          order.tracking_number  = data[:tracking_number]
          if order.changes.present?
            puts "#{debug_prefix} has changes: #{order.changes.inspect}"
            order[:last_changed_at] = Time.zone.now  
            order.save
          else
            order.touch
            puts "#{debug_prefix} has no changes."
          end
        else
          puts "#{debug_prefix} is not a valid DJI order. Unable to find it on DJI's website."
        end
      else
        puts "#{debug_prefix} is not a valid DJI order. Phone tail is not provided."
      end

      # Add some delay so that we're not hitting DJI's website too hard
      sleep 2
    end
  end

  task shipment_tracking: :environment do
    puts "Updating Shipment Tracking"
    puts "-------------------------------------------------------------------"
    puts

    orders = Order.order(order_time: :asc)

    orders.each_with_index do |order, index|
      options = { order_number: order.order_id, phone_tail: order.phone_tail }

      if order.tracking_number.present?
        order.delivery_status = 'enroute' if order.shipping_status.downcase == 'shipped'
        
        case order.shipping_company.downcase
        when 'dhl' then
          tr = DJI::DHL.track(order.tracking_number)
          shipment = tr.shipments.first
          if shipment.present?
            puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} #{order.pretty_shipping_company} shipment with waybill #{shipment.waybill} has an estimated delivery date of #{shipment.estimated_delivery_date}"
            puts shipment.inspect
            order.update(estimated_delivery_at: shipment.estimated_delivery_date, delivery_status: 'enroute')
          else
            puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has invalid #{order.pretty_shipping_company} waybill #{order.tracking_number}!"
          end
        else
          puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has a currently unsupported shipper '#{order.shipping_company}'."
        end
      else
        puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has no tracking number."
      end
    end
  end

end