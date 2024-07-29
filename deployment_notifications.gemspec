# frozen_string_literal: true

require_relative 'lib/deployment_notifications/version'

Gem::Specification.new do |spec|
  spec.name          = 'deployment_notifications'
  spec.version       = DeploymentNotifications::VERSION
  spec.authors       = ['Ashish Garg']
  spec.email         = '01ashishgarg@gmail.com'

  spec.summary       = 'Deliver deployment notifications to Slack'
  spec.description   = 'Deliver Capistrano deployment notifications to Slack'
  spec.homepage      = 'https://github.com/aashishgarg/deployment_notifications'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/aashishgarg/deployment_notifications'
  spec.metadata['changelog_uri']   = 'https://github.com/aashishgarg/deployment_notifications/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Specify the dependencies of the gem
  spec.add_dependency 'slackistrano'
end
