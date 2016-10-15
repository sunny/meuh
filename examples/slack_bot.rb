# Register a bot at http://slack.com/services/new/bot
# then call:
#
# ```sh
# $ SLACK_API_TOKEN=… ruby -Ilib examples/slack_bot.rb
# ```

require "slack-ruby-bot"
require "meuh/slack_plugin"

class MeuhBot < SlackRubyBot::Bot
  extend Meuh::SlackPlugin
end

MeuhBot.run
