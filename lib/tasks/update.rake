namespace :update do

  task order_status: :environment do
    puts "Updating DJI Order Statuses"
    puts "-----------------------------------------------------------------------------"
    puts

    orders = Order.order(updated_at: :asc)

    orders.each_with_index do |order, index|
      count        = index + 1
      debug_prefix = "#{count} - Order #{order.order_id}/#{order.phone_tail}"

      result = if order.order_id.present? && order.phone_tail.present?
        options = { order_number: order.order_id, phone_tail: order.phone_tail, debug: false }
        data    = DJI::OrderTracking.tracking_details(options)

        if data.present?
          order.payment_total    = data[:total]
          case data[:shipping_status]
          when 'Received'
            order.shipping_status = 'Shipped'
            order.delivery_status = 'delivered'
          else
            order.shipping_status  = data[:shipping_status]
          end
          order.shipping_company = data[:shipping_company].presence || 'Tba'
          order.tracking_number  = data[:tracking_number]

          if order.changes.present?
            puts "#{debug_prefix} has changes: #{order.changes.inspect}"
            changes = order.changes
            order[:last_changed_at] = Time.zone.now  
            order.save(validate: false)

            OrderStateLog.track_changes(order, changes)

            { success: true, changed: true, changes: changes }
          else
            order.touch
            puts "#{debug_prefix} has no changes."
            { success: true, changed: false, changes: nil }
          end
        else
          puts "#{debug_prefix} is not a valid DJI order. Unable to find it on DJI's website."
          { success: false, changed: true, changes: nil, error: 'Invalid DJI order. Record not found.', error_code: :invalid_dji_order, error_reason_code: :record_not_found }
        end
      else
        puts "#{debug_prefix} is not a valid DJI order. Phone tail is not provided."
        { success: false, changed: true, changes: nil, error: 'Invalid DJI order. Phoen tail not provided.', error_code: :invalid_dji_order, error_reason_code: :invalid_phone_tail }
      end

      if result[:success]
        order.update_attribute(:dji_lookup_success, true)
        order.update_attribute(:dji_lookup_error_code, nil)
        order.update_attribute(:dji_lookup_error_reason_code, nil)
      else
        order.update_attribute(:dji_lookup_success, false)
        order.update_attribute(:dji_lookup_error_code, result[:error_code])
        order.update_attribute(:dji_lookup_error_reason_code, result[:error_reason_code])
      end

      # Add some delay so that we're not hitting DJI's website too hard
      sleep 2
    end
  end

  task shipment_tracking: :environment do
    puts "Updating Shipment Tracking"
    puts "-----------------------------------------------------------------------------"
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