[![Code Climate](https://codeclimate.com/github/factor-io/connector-slack/badges/gpa.svg)](https://codeclimate.com/github/factor-io/connector-slack)
[![Test Coverage](https://codeclimate.com/github/factor-io/connector-slack/badges/coverage.svg)](https://codeclimate.com/github/factor-io/connector-slack)
[![Build Status](https://travis-ci.org/factor-io/connector-slack.svg)](https://travis-ci.org/factor-io/connector-slack)
[![Dependency Status](https://gemnasium.com/factor-io/connector-slack.svg)](https://gemnasium.com/factor-io/connector-slack)
[![Gem Version](https://badge.fury.io/rb/factor-connector-slack.svg)](http://badge.fury.io/rb/factor-connector-slack)

Factor.io Slack Connector
===============

Slack Connector for Factor.io

The connector-slack ruby gem is used to run actions in Slack. It was built with the [factor.io connector-api](https://github.com/factor-io/connector-api) An action could Creating a private group, inviting another user to it and posting a message.

## Installation
Add this to your `Gemfile` in your [Connector](https://github.com/factor-io/connector)
```ruby
gem 'factor-connector-slack', '~> 0.0.3'
```

Add this to your `init.rb`  in your [Connector](https://github.com/factor-io/connector)

```ruby
require 'factor/connector/slack_channel'
require 'factor/connector/slack_group'
require 'factor/connector/slack_chat'
require 'factor/connector/slack_user'
```

The [Connectors README](https://github.com/factor-io/connector#running) shows you how to run the Connector Server with this new connector integrated.

## Setup and Usage
**[Setup your workflows](https://github.com/factor-io/connector-slack/wiki/Setup-your-Workflows)**: To use the connector in your workflow when you run `factor s` you must setup your `credentials.yml` and `connectors.yml` files. Find out how there.

**[Usage: Actions](https://github.com/factor-io/connector-slack/wiki/Actions)**: This will show you all the actions you can use in your workflows on Slack along with some examples.

## Testing
To run tests locally we need to clone the repo, set the env variables that are referred to below. Then, we run rake in our terminal. Currently we need to set our env's to the ID's. We can set our env's in our terminal:

    $ export SLACK_TOKEN=8675309
    $ export SLACK_CHANNEL=133743732
    $ export SLACK_USER=563252338

#### ENV['SLACK_TOKEN']
You can find your [Token](https://api.slack.com/) there.

#### ENV['SLACK_CHANNEL']
And, your [Channel](https://api.slack.com/methods/channels.list/test) options there. Just pick a channel id after you click go.

#### ENV['SLACK_USER']
For your user you'll want to create a test user account, the get your [User](https://api.slack.com/methods/users.list/test) id here.

Then, you can bundle and test:

    $ bundle install
    $ bundle exec rake

## Contribute? Bug reports and pull requests!
Want to contribute?<br>
[Bug reports are very welcome!!](https://github.com/factor-io/connector-slack/issues/new)

[So are contributions and pull requests](https://github.com/factor-io/factor/wiki/Contribution).
