class User < ApplicationRecord
  enum role: [:user, :vip, :contributor, :editor, :admin]
  after_initialize :set_default_role, if: :new_record?

  validates :username, presence: true, uniqueness: true

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
