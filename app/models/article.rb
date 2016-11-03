class Article < ApplicationRecord

  def to_param
    "#{id}-#{title.downcase.gsub(' ', '-').dasherize}"
  end

end
