class NotificationService

  class << self

    def notify(options = {})
      return nil if options[:destinations].blank?

      destinations = options.delete(:destinations)
      destinations.each do |destination|
        case destination[:medium]
        when :slack
          SlackService.notify(options.merge(channel: destination[:channel]))
        else
          puts "NotifcationService: Unknown :medium provided '#{destination[:medium]}' for destination."
        end
      end
    end

  end

end