require "administrate/base_dashboard"

class OrderDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    merchant: Field::BelongsTo,
    order_state_logs: Field::HasMany,
    product: Field::BelongsTo,
    owner: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::Number,
    owner_id: Field::Number,
    order_id: Field::String,
    order_time: Field::DateTime,
    payment_status: Field::String,
    payment_method: Field::String,
    payment_total: Field::String,
    shipping_address: Field::String,
    shipping_address_line_2: Field::String,
    shipping_city: Field::String,
    shipping_region_code: Field::String,
    shipping_postal_code: Field::String,
    shipping_country: Field::String,
    shipping_country_code: Field::String,
    shipping_phone: Field::String,
    shipping_status: Field::String,
    shipping_company: Field::String,
    tracking_number: Field::String,
    email_address: Field::String,
    access_key: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    last_changed_at: Field::DateTime,
    dji_username: Field::String,
    phone_tail: Field::String,
    estimated_delivery_at: Field::DateTime,
    delivery_status: Field::String,
    delivered_at: Field::DateTime,
    dji_lookup_success: Field::Boolean,
    dji_lookup_error_code: Field::String,
    dji_lookup_error_reason_code: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :merchant,
    :order_state_logs,
    :product,
    :owner,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :merchant,
    :order_state_logs,
    :product,
    :owner,
    :id,
    :owner_id,
    :order_id,
    :order_time,
    :payment_status,
    :payment_method,
    :payment_total,
    :shipping_address,
    :shipping_address_line_2,
    :shipping_city,
    :shipping_region_code,
    :shipping_postal_code,
    :shipping_country,
    :shipping_country_code,
    :shipping_phone,
    :shipping_status,
    :shipping_company,
    :tracking_number,
    :email_address,
    :access_key,
    :created_at,
    :updated_at,
    :last_changed_at,
    :dji_username,
    :phone_tail,
    :estimated_delivery_at,
    :delivery_status,
    :delivered_at,
    :dji_lookup_success,
    :dji_lookup_error_code,
    :dji_lookup_error_reason_code,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :merchant,
    :order_state_logs,
    :product,
    :owner,
    :owner_id,
    :order_id,
    :order_time,
    :payment_status,
    :payment_method,
    :payment_total,
    :shipping_address,
    :shipping_address_line_2,
    :shipping_city,
    :shipping_region_code,
    :shipping_postal_code,
    :shipping_country,
    :shipping_country_code,
    :shipping_phone,
    :shipping_status,
    :shipping_company,
    :tracking_number,
    :email_address,
    :access_key,
    :last_changed_at,
    :dji_username,
    :phone_tail,
    :estimated_delivery_at,
    :delivery_status,
    :delivered_at,
    :dji_lookup_success,
    :dji_lookup_error_code,
    :dji_lookup_error_reason_code,
  ].freeze

  # Overwrite this method to customize how orders are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(order)
  #   "Order ##{order.id}"
  # end
end
