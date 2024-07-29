require 'slackistrano'
require 'deployment_notifications/deployment_messaging'

module DeploymentNotifications
  class Notifier
    def self.setup_slackistrano
      Slackistrano.configure do |config|
        config.channel = DeploymentNotifier.channel
        config.webhook = DeploymentNotifier.webhook

        config.messaging = Slackistrano::DeploymentMessaging
      end
    end
  end
end
