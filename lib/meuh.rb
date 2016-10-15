require "meuh/version"
require "meuh/brain"
require "meuh/message"

require "meuh/plugins/lol"
require "meuh/plugins/lu"
require "meuh/plugins/mention_bot"
require "meuh/plugins/ping"
require "meuh/plugins/question_to_bot"
require "meuh/plugins/repeat"
require "meuh/plugins/replace"
require "meuh/plugins/what"
require "meuh/plugins/where"
require "meuh/plugins/who"

module Meuh
  # The order of the plugins is important, since they are called in that order
  PLUGINS = [
    Plugins::Replace,

    Plugins::Lol,
    Plugins::Lu,
    Plugins::Ping,
    Plugins::What,
    Plugins::Where,
    Plugins::Who,

    Plugins::QuestionToBot,
    Plugins::MentionBot,

    Plugins::Repeat,
  ]
end
