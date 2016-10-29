class Order < ApplicationRecord
  before_save :default_order

  belongs_to :merchant

  scope :shipped, -> { where(shipping_status: 'Shipped') }

  validates :order_id, presence: true, length: { is: 12 }
  validates :phone_tail, presence: true, length: { is: 4 }

  def default_order
    self.last_changed_at  ||= Time.zone.now
    self.payment_status   ||= ''
    self.shipping_company ||= ''
    self.shipping_country ||= ''
    self.shipping_status  ||= ''
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

  def pretty_shipping_company
    case shipping_company.downcase
    when 'tba' then 'Pending'
    when 'dhl' then 'DHL'
    else
      shipping_company.upcase
    end
  end

  def shipping_company_class
    case shipping_company.downcase
    when 'tba' then 'shipping-company-pending'
    when 'dhl' then 'shipping-company-selected'
    else
      'shipping-company-unknown'
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
