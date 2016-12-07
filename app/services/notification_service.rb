class NotificationService

  class << self

    def notify(options = {})
      return nil if options[:destinations].blank?

      options[:destinations].each do |destination|
        case destination[:medium]
        when :slack
          notify_slack(channel: destination[:channel], message: options[:message])
        else
          puts "NotifcationService: Unknown :medium provided '#{destination[:medium]}' for destination."
        end
      end
    end

    def notify_slack(options = {})
      slack   = Slack::Web::Client.new
      channel = options[:channel]
      message = options[:message]

      return nil if channel.blank? || message.blank?

      puts "NotificationService: Posting notification to Slack."
      slack.chat_postMessage(
        channel: channel,
        text: message,
        as_user: true
      )
    end

  end

end