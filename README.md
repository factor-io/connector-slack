[![Code Climate](https://codeclimate.com/github/factor-io/connector-slack/badges/gpa.svg)](https://codeclimate.com/github/factor-io/connector-slack)
[![Test Coverage](https://codeclimate.com/github/factor-io/connector-slack/badges/coverage.svg)](https://codeclimate.com/github/factor-io/connector-slack)
[![Build Status](https://travis-ci.org/factor-io/connector-slack.svg)](https://travis-ci.org/factor-io/connector-slack)
[![Dependency Status](https://gemnasium.com/factor-io/connector-slack.svg)](https://gemnasium.com/factor-io/connector-slack)
[![Gem Version](https://badge.fury.io/rb/factor-connector-slack.svg)](http://badge.fury.io/rb/factor-connector-slack)

Factor.io Slack Connector
===============

Slack Connector for Factor.io

The connector-slack ruby gem is used to run actions in Slack. It was built with the [factor.io connector-api](https://github.com/factor-io/connector-api) An action could Creating a private group, inviting another user to it and posting a message.

## Using connector-slack
To use the actions defined well need to generate a [Token](https://api.slack.com/). Scroll down and you'll find it.

    listen 'timer::every', minutes:1 do |post_info|
      run 'slack::chat::send', :token => 'token', :channel => 'channel_name', :text => 'Save the Whales'
    end

## Functionality
##### slack_channel
list - list all channels<br>
invite - invite a user to your channel<br>
history - see the history<br>
topic - set the topic<br>

##### slack_chat
send - send a message<br>

##### slack group
create - create a group<br>
invite - invite a user to your private group<br>

##### slack_user
list - list all users<br>

## Testing
To run tests locally we need to clone the repo, set the env variables that are referred to below. Then, we run rake in our terminal. Currently we need to set our env's to the ID's. We can set our env's in our terminal:

    $ export SLACK_TOKEN=8675309
    $ export SLACK_CHANNEL=133743732
    $ export SLACK_USER=563252338

#### ENV['SLACK_TOKEN']
You can find your [Token](https://api.slack.com/) there.

#### ENV['SLACK_CHANNEL']
And, you [Channel](https://api.slack.com/methods/channels.list/test) options there. Just pick a channel id after you click go.

#### ENV['SLACK_USER']
For your user you'll want to create a test user account, and then grab the [User](https://api.slack.com/methods/users.list/test) id here.

Then, you can bundle and test:

    $ bundle install
    $ bundle exec rake

## Contribute
Want to contribute?
https://github.com/factor-io/factor/wiki/Contribution
