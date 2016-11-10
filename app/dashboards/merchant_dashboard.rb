require "administrate/base_dashboard"

class MerchantDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    orders: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    website: Field::String,
    referral_code: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    common_name: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :orders,
    :id,
    :name,
    :description,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :orders,
    :id,
    :name,
    :description,
    :website,
    :referral_code,
    :status,
    :created_at,
    :updated_at,
    :common_name,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :orders,
    :name,
    :description,
    :website,
    :referral_code,
    :status,
    :common_name,
  ].freeze

  # Overwrite this method to customize how merchants are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(merchant)
  #   "Merchant ##{merchant.id}"
  # end
end
