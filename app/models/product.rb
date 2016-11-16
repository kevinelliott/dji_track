class Product < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :product_family

  acts_as_taggable_on :features

  scope :accessories, -> { where(accessory: true) }
  scope :non_accessories, -> { where(accessory: false) }
  scope :published, -> { where(status: 'published') }

  def amazon_affiliate_code
    "dronehome00-20"
  end

  def amazon_url
    id = asin.presence || upc.presence
    "http://www.amazon.com/dp/#{id}/?tag=#{amazon_affiliate_code}"
  end

  def manufacturer_product_name
    "#{manufacturer.name} #{name}"
  end
end
