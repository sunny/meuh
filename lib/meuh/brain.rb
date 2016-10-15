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

# coding: utf-8
module Meuh
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

  class Message
    attr_reader :text,
                :nickname,
                :botname,
                :nicknames,
                :previous_message,
                :previous_nickname

    def initialize(text:, nickname:, botname:, nicknames:, previous_message:, previous_nickname:)
      @text = text
      @nickname = nickname
      @botname = botname
      @nicknames = nicknames
      @previous_message = previous_message
      @previous_nickname = previous_nickname
    end
  end

  # Artificial intelligence
  class Brain
    attr_accessor :botname

    def initialize(botname: nil)
      @botname = botname
    end

    # Respond to a message. Yields the response if there is one.
    #
    # Arguments:
    # - nickname : user's name who sent the message
    # - message : text message
    # - nicknames : array of active user nicks on the channel
    #
    # Example:
    #     bot = MeuhBot.new
    #     bot.message(nickname: "sunny", message: "Hi!", nicknames: ["sunny", "NaPs"]) do |response|
    #       puts response
    #     end
    def message(nickname: nil, message: nil, nicknames: nil)
      answer = false

      msg = Message.new(
        text: message,
        nickname: nickname,
        botname: botname,
        nicknames: nicknames,
        previous_message: previous_message,
        previous_nickname: previous_nickname
      )

      # Do not record this as a previous message
      return if msg.text =~ /^!/

      plugins.each do |plugin|
        answer = plugin.answer(msg)
        if answer
          yield answer
          break
        end
      end

      # Remember what the person said
      if answer
        @previous_message = answer
        @previous_nickname = botname
      else
        @previous_message = message
        @previous_nickname = nickname
      end
    end

    private

    attr_reader :previous_message, :previous_nickname

    def plugins
      @plugins ||= PLUGINS.map(&:new)
    end
  end

end
