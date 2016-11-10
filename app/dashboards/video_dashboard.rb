require "administrate/base_dashboard"

class VideoDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    streaming_site: Field::BelongsTo,
    user: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    summary: Field::Text,
    description: Field::Text,
    url: Field::String,
    channel_name: Field::String,
    channel_url: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    published_at: Field::DateTime,
    thumbnail_url_small: Field::String,
    thumbnail_url_medium: Field::String,
    thumbnail_url_large: Field::String,
    embed_url: Field::String,
    embed_code: Field::Text,
    provider_published_at: Field::DateTime,
    duration: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :streaming_site,
    :title,
    :user,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :streaming_site,
    :user,
    :id,
    :title,
    :summary,
    :description,
    :url,
    :channel_name,
    :channel_url,
    :status,
    :created_at,
    :updated_at,
    :published_at,
    :thumbnail_url_small,
    :thumbnail_url_medium,
    :thumbnail_url_large,
    :embed_url,
    :embed_code,
    :provider_published_at,
    :duration,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :streaming_site,
    :user,
    :title,
    :summary,
    :description,
    :url,
    :channel_name,
    :channel_url,
    :status,
    :published_at,
    :thumbnail_url_small,
    :thumbnail_url_medium,
    :thumbnail_url_large,
    :embed_url,
    :embed_code,
    :provider_published_at,
    :duration,
  ].freeze

  # Overwrite this method to customize how videos are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(video)
  #   "Video ##{video.id}"
  # end
end
