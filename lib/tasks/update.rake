namespace :update do

  task order_status: :environment do
    puts "Updating DJI Order Statuses"
    puts "-------------------------------------------------------------------"
    puts

    orders = Order.order(updated_at: :asc).limit(10)

    orders.each_with_index do |order, index|
      options = { order_number: order.order_id, phone_tail: order.phone_tail }

      data = DJI::OrderTracking.tracking_details(options)

      if data.present?
        order.payment_total    = data[:total]
        order.shipping_status  = data[:shipping_status]
        order.shipping_company = data[:shipping_company]
        order.tracking_number  = data[:tracking_number]
        if order.changes.present?
          puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has changes: #{order.changes.inspect}"
          order[:last_changed_at] = Time.zone.now  
          order.save
        else
          puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has no changes."
        end
      else
        puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} is not a valid DJI order."
      end

      # Add some delay so that we're not hitting DJI's website too hard
      sleep 2
    end
  end

  task shipment_tracking: :environment do
    puts "Updating Shipment Tracking"
    puts "-------------------------------------------------------------------"
    puts

    orders = Order.where('LOWER(shipping_company) = ?', 'dhl')

    orders.each_with_index do |order, index|
      options = { order_number: order.order_id, phone_tail: order.phone_tail }

      if order.tracking_number.present?
        case order.shipping_company.downcase
        when 'dhl' then
          tr = DJI::DHL.track(order.tracking_number)
          shipment = tr.shipments.first
          if shipment.present?
            puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} shipment with waybill #{shipment.waybill} has an estimated delivery date of #{shipment.estimated_delivery_date}"
            order.update(estimated_delivery_at: shipment.estimated_delivery_date, delivery_status: 'enroute')
          else
            puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has invalid waybill #{order.tracking_number}!"
          end
        else
          puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has a currently unsupported shipper #{order.shipping_company}."
        end
      else
        puts "#{index + 1} - Order #{order.order_id}/#{order.phone_tail} has no tracking number."
      end
    end
  end

end