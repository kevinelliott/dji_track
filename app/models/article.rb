class Article < ApplicationRecord

  belongs_to :user

  def notify_slack
    message = "A new DroneHome article has been published: #{title} at http://www.dronehome.io/news"

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
