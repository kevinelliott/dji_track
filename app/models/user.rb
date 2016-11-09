class User < ApplicationRecord
  enum role: [:user, :vip, :contributor, :editor, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_many :orders, foreign_key: :owner_id, dependent: :nullify

  validates :username, presence: true, uniqueness: true

  def gravatar_url
    require 'digest/md5'
    token = if email.present?
      Digest::MD5.hexdigest(email.downcase)
    else
      dji_username.presence || 'unknown'
    end
    "https://www.gravatar.com/avatar/#{token}"
  end

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
