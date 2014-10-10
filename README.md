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
To use the actions defined well need to generate a [Token](https://api.slack.com/). 

## Testing
To run tests locally we need to clone the repo, set the env variables that are referred to at top of the spec files. Then, we run rake in our terminal.
