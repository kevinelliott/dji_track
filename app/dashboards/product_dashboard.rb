require "administrate/base_dashboard"

class ProductDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    manufacturer: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    code: Field::String,
    description: Field::Text,
    logo_url: Field::String,
    website: Field::String,
    upc: Field::String,
    asin: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    dji_store_url: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :manufacturer,
    :id,
    :name,
    :code,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :manufacturer,
    :id,
    :name,
    :code,
    :description,
    :logo_url,
    :website,
    :upc,
    :asin,
    :status,
    :created_at,
    :updated_at,
    :dji_store_url,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :manufacturer,
    :name,
    :code,
    :description,
    :logo_url,
    :website,
    :upc,
    :asin,
    :status,
    :dji_store_url,
  ].freeze

  # Overwrite this method to customize how products are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(product)
    "#{product.manufacturer.common_name} #{product.name}"
  end
end
