if defined?(Slackistrano::Messaging)
  module Slackistrano
    class DeploymentMessaging < Messaging::Base

      def info_item(item, value)
        "• #{item} - _*#{value.to_s.gsub("\n", '')}*_"
      end

      def info_list(items)
        items.join(" \n ")
      end

      def payload_for_starting
        deployer_name = ENV['DEPLOYER_NAME'] || `git log -n 1 --format='%ae'`

        if ENV['DEPLOYMENT_IDENTIFIER']
          deployment_identifier = ENV['DEPLOYMENT_IDENTIFIER']
        else
          deployment_identifier = Time.now.strftime("%Y%m%d_%H%M%S")
          ENV['DEPLOYMENT_IDENTIFIER'] = deployment_identifier
        end

        {
          "blocks": [
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": 'Deployment _*Started*_ for _*Eportfolio*_ application :wave:'
              }
            },
            { "type": 'divider' },
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": '_Information related to this deployment_:'
              }
            },
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": info_list([
                                    info_item('Deployer name', deployer_name),
                                    info_item('Deployment identifier', deployment_identifier),
                                    info_item('Env', ENV['ENV_NAME'] || stage),
                                    info_item('Branch', ENV['BRANCH_NAME'] || branch),
                                    info_item('Last commit by', ENV['LAST_COMMIT_AUTHOR'] || `git log -n 1 --format='%ae'`),
                                    info_item('Commit time', ENV['LAST_COMMIT_TIME'] || `git show -s --format=%cd`),
                                    info_item('Commit id', ENV['LAST_COMMIT_ID'] || `git rev-parse --short HEAD`),
                                    info_item('Commit message', ENV['LAST_COMMIT_MESSAGE'] || `git show -s --format=%s`)
                                  ])
              }
            }
          ]
        }
      end

      # Suppress updating message.
      def payload_for_updating
        nil
      end

      # Fancy updated message.
      # See https://api.slack.com/docs/message-attachments
      def payload_for_updated
        {
          attachments: [{
                          color: 'good',
                          title: "#{application} Deployed :boom::bangbang:",
                          fields: [{
                                     title: 'Deployment Identifier',
                                     value: ENV['DEPLOYMENT_IDENTIFIER'],
                                     short: true
                                   },{
                                     title: 'Environment',
                                     value: stage,
                                     short: true
                                   }, {
                                     title: 'Branch',
                                     value: branch,
                                     short: true
                                   }, {
                                     title: 'Time',
                                     value: elapsed_time,
                                     short: true
                                   }],
                          fallback: super[:text]
                        }],
          text: "<!here> #{application} Application Deployed!"
        }
      end

      # Slightly tweaked failed message.
      # See https://api.slack.com/docs/message-formatting
      def payload_for_failed
        payload = super
        payload[:text] = "OMG :fire: #{payload[:text]}"
        payload
      end
    end
  end
end
