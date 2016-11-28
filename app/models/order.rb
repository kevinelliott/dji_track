class Order < ApplicationRecord
  before_save :default_order

  belongs_to :merchant
  has_many :order_state_logs, dependent: :destroy
  belongs_to :product, optional: true
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  scope :not_canceled, -> { where('LOWER(payment_status) != ?', 'canceled') }
  scope :not_delivered, -> { where('LOWER(delivery_status) != ?', 'delivered') }
  scope :not_shipped, -> { where('LOWER(shipping_status) != ?', 'shipped') }

  scope :canceled, -> { where('LOWER(payment_status) = ?', 'canceled' ) }
  scope :enroute, -> { where('LOWER(delivery_status) = ?', 'enroute')}
  scope :delivered, -> { where('LOWER(delivery_status) = ?', 'delivered') }
  scope :shipped, -> { where('LOWER(shipping_status) = ?', 'shipped') }

  scope :with_order_id, -> { where('order_id IS NOT NULL AND order_id != ?', '') }
  scope :with_phone_tail, -> { where('phone_tail IS NOT NULL AND phone_tail != ?', '') }

  validates :order_id, presence: true, length: { in: 12..13 }, if: Proc.new { |o| o.merchant.common_name == 'DJI' }
  validates :phone_tail, presence: true, length: { is: 4 }

  class << self

    def generate_safe_id
      source_chars = ('a'..'z').to_a + ('0'..'9').to_a
      source_chars.shuffle[0,4].join
    end

    def unique_safe_id
      while true
        safe_id = generate_safe_id
        return safe_id if Order.where(safe_id: safe_id).count == 0
      end
    end

  end

  def default_order
    # Set defaults
    self.last_changed_at  ||= Time.zone.now
    self.payment_status   ||= ''
    self.safe_id          ||= Order.unique_safe_id
    self.shipping_company ||= ''
    self.shipping_country ||= ''
    self.shipping_status  ||= ''
  end

  def delivered_in_days
    delivery = delivered_at.presence || estimated_delivery_at.presence
    if delivery.present? && order_time.present?
      (order_time - delivery).abs / 60 / 60 / 24
    else
      nil
    end
  end

  def delivery_status_class
    case delivery_status
    when 'delivered' then 'delivery-status-delivered'
    when 'enroute' then
      if estimated_delivery_at.present? && Time.current > estimated_delivery_at
        'delivery-status-arriving'
      else
        'delivery-status-enroute'
      end
    when 'pending' then 'delivery-status-pending'
    else
      'delivery-status-unknown'
    end
  end

  def gravatar_url
    require 'digest/md5'
    token = if email_address.present?
      Digest::MD5.hexdigest(email_address.downcase)
    else
      dji_username.presence || 'unknown'
    end
    "https://www.gravatar.com/avatar/#{token}"
  end

  def masked_order_id
    order_id.present? ? "#{order_id.slice(0..-5)}****" : nil
  end

  def order_table_row_class
    if delivery_status.eql?('delivered')
      'table-success'
    elsif shipping_status.eql?('canceled')
      'table-danger'
    end
  end

  def payment_status_class
    case payment_status.try(:downcase)
    when 'pay confirmed' then 'payment-status-pay-confirmed'
    when 'pending' then 'payment-status-pending'
    when 'canceled' then 'order-canceled'
    else
      'payment-status-unknown'
    end
  end

  def pretty_shipping_company
    case shipping_company.downcase
    when 'canceled' then 'Canceled'
    when 'tba' then 'Pending'
    when 'dhl' then 'DHL'
    when 'fedex' then 'FedEx'
    when 'sagawa' then 'Sagawa'
    else
      shipping_company.upcase
    end
  end

  def shipping_company_class
    valid_shipping_companies = %w[
      dhl fedex ups usps sagawa
    ]

    case shipping_company.downcase
    when '' then 'shipping-company-pending'
    when 'canceled' then 'order-canceled'
    when 'tba' then 'shipping-company-pending'
    when *valid_shipping_companies then 'shipping-company-selected'
    else
      'shipping-company-unknown'
    end
  end

  def shipping_status_class
    case shipping_status.downcase.to_sym
    when :canceled then 'order-canceled'
    when :pending then 'shipping-status-pending'
    when :shipped then 'shipping-status-shipped'
    else
      'shipping-status-unknown'
    end
  end
end
