class Article < ApplicationRecord

  belongs_to :user

  def to_param
    "#{id}-#{title.downcase.gsub(' ', '-').dasherize}"
  end

end
