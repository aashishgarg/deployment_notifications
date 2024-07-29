# DeploymentNotifications

`DeploymentNotifications` is a gem that integrates with Capistrano and Slackistrano to provide custom deployment messages to your Slack channel. This gem simplifies the setup process by automatically configuring the necessary settings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deployment_notifications', path: '/path/to/your/local/gem'
```

And then execute:

```bash
bundle install
```

## Configuration

### Step 1: Configure the Gem in an Initializer
Create a new initializer file in your Rails application, e.g., config/initializers/deployment_notifications.rb, and configure it as follows:

```ruby
DeploymentNotifications.configure do |config|
  config.channel = '#your-slack-channel'
  config.webhook = 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
end
```

### Step 2: Capfile Modifications
The gem automatically adds the necessary require 'slackistrano/capistrano' line to your Capfile. If you need to verify or manually add it, your Capfile should include:

```ruby
require 'slackistrano/capistrano'
```

### Step 3: Deployment Configuration
Ensure that your Capistrano deploy configuration is set up correctly. The gem will automatically set the Slackistrano configuration based on the provided initializer settings.

## Usage
Once configured, you can deploy your application using Capistrano as usual:

```bash
cap production deploy
```

Deployment notifications will be sent to your specified Slack channel using the custom messaging format defined in the DeploymentNotifications gem.

## Custom Messaging
The gem provides a custom messaging format for deployment notifications. It sends detailed deployment information at the start, success, and failure stages of your deployment process.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/your-username/deployment_notifications.

## License
The gem is available as open-source under the terms of the MIT License.

Make sure to replace `'/path/to/your/local/gem'` with the actual path to your gem and update the GitHub repository URL to your actual repository.
