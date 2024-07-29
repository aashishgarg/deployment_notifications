require 'rails/railtie'
require 'deployment_notifications/notifier'

module DeploymentNotifications
  class Railtie < Rails::Railtie
    class Railtie < Rails::Railtie
      initializer 'deployment_notifier.add_to_capfile' do
        capfile_path = Rails.root.join('Capfile')
        if File.exist?(capfile_path)
          content = File.read(capfile_path)
          unless content.include?("require 'slackistrano/capistrano'")
            File.open(capfile_path, 'a') do |file|
              file.puts("\nrequire 'slackistrano/capistrano'\n")
            end
          end
        end
      end

      initializer 'deployment_notifications.configure_capistrano' do |app|
        # Automatically configure Capistrano settings
        if defined?(Capistrano::Configuration)
          Capistrano::Configuration.instance.load do
            set :slackistrano, {
              channel: DeploymentNotifications.channel,
              webhook: DeploymentNotifications.webhook,
              klass: Slackistrano::DeploymentMessaging
            }
          end
        end
      end
    end
  end
end
