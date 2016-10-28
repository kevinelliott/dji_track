class Order < ApplicationRecord
  before_save :default_order

  def default_order
    self.last_changed_at ||= Time.zone.now
  end

  def masked_order_id
    order_id.present? ? "#{order_id.slice(0..-5)}****" : nil
  end

  def payment_status_class
    case payment_status
    when 'Pay Confirmed' then 'payment-status-pay-confirmed'
    when 'Pending' then 'payment-status-pending'
    else
      'payment-status-unknown'
    end
  end

  def shipping_status_class
    case shipping_status.downcase.to_sym
    when :pending then 'shipping-status-pending'
    when :shipped then 'shipping-status-shipped'
    else
      'shipping-status-unknown'
    end
  end
end
