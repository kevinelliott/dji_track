class ProductFamily < ApplicationRecord
  belongs_to :manufacturer
  has_many :products
end
