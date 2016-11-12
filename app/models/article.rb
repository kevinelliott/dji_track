class Article < ApplicationRecord

  belongs_to :user

  def notify_slack
    message = "#{order.merchant.common_name}: Order #{order.masked_order_id} for #{order.product.name} on #{order.order_time.presence || 'an unknown Order Time'} to #{(order.shipping_country.presence || 'UNKNOWN').upcase} was just shipped."

    slack = Slack::Web::Client.new
    slack.chat_postMessage(
      channel: '#general',
      text: message,
      as_user: true
    )
  end

  def publish!
    self.update(status: 'published', published_at: Time.current)
    notify_slack
  end

  def to_param
    "#{id}-#{title.downcase.gsub(' ', '-').dasherize}"
  end

end
