class Product < ApplicationRecord
  belongs_to :manufacturer

  def amazon_affiliate_code
    "dronehome00-20"
  end

  def amazon_url
    id = asin.presence || upc.presence
    "http://www.amazon.com/dp/#{id}/?tag=#{amazon_affiliate_code}"
  end
end
