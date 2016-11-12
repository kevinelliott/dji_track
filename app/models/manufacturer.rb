class Manufacturer < ApplicationRecord
  has_many :product_families
  has_many :products
end
