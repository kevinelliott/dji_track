class Video < ApplicationRecord
  belongs_to :streaming_site
  belongs_to :user, required: false

  scope :published, -> { where(status: 'published') }

  validates :title, presence: true
  validates :summary, presence: true
  validates :url, presence: true
  validates :status, presence: true
end
