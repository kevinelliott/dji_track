class ProductFamily < ApplicationRecord

  belongs_to :manufacturer
  has_many :products

  scope :active, -> { where(status: 'active') }

end
