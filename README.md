[![Code Climate](https://codeclimate.com/github/factor-io/connector-slack/badges/gpa.svg)](https://codeclimate.com/github/factor-io/connector-slack)
[![Test Coverage](https://codeclimate.com/github/factor-io/connector-slack/badges/coverage.svg)](https://codeclimate.com/github/factor-io/connector-slack)
[![Build Status](https://travis-ci.org/factor-io/connector-slack.svg)](https://travis-ci.org/factor-io/connector-slack)
[![Dependency Status](https://gemnasium.com/factor-io/connector-slack.svg)](https://gemnasium.com/factor-io/connector-slack)
[![Gem Version](https://badge.fury.io/rb/factor-connector-slack.svg)](http://badge.fury.io/rb/factor-connector-slack)

Factor.io Slack Connector
===============

Slack Connector for Factor.io

The connector-slack ruby gem is used to run actions in Slack. It was built with the [factor.io connector-api](https://github.com/factor-io/connector-api) An action can be posting a message, uploading a file or inviting another user to the channel.

## Using connector-slack
To use the actions defined well need to generate a [Token](https://api.slack.com/). Currently we also need to find the [channel id](https://api.slack.com/methods/channels.list/test), just press go and you'll receive a response containing your channel ids. 

    listen 'timer::every', minutes:1 do |post_info|
      run 'slack_channel::send', :token => 'token', :channel => 'channel id', :text => 'testing' 
    end

## Testing
To run tests locally we need to clone the repo, set the env variables that are referred to at top of the spec files. Then, we run rake in our terminal.

## Contribute
Want to contribute?
https://github.com/factor-io/factor/wiki/Contribution
