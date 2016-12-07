class NotificationService

  class << self

    def notify(options = {})
      return nil if options[:destinations].blank?

      options[:destinations].each do |destination|
        case destination[:medium]
        when :slack
          SlackService.notify(options)
        else
          puts "NotifcationService: Unknown :medium provided '#{destination[:medium]}' for destination."
        end
      end
    end

  end

end