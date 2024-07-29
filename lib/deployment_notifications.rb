# frozen_string_literal: true

require 'slackistrano'
require_relative "deployment_notifications/railtie"
require_relative "deployment_notifications/version"

module DeploymentNotifications
  class << self
    attr_accessor :channel, :webhook

    def configure
      yield self
    end
  end

  class Notifier; end

  class Error < StandardError; end
  # Your code goes here...
end
