class Article < ApplicationRecord

  def to_param
    "#{id}-#{subject.downcase.gsub(' ', '-').dasherize}"
  end

end
