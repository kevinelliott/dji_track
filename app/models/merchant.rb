class Merchant < ApplicationRecord
  has_many :orders

  scope :active, -> { where(status: 'active') }
end
