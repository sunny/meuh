require "meuh"
require "cinch"

module Meuh

  # Plugin for Cinch
  class CinchPlugin
    include Cinch::Plugin

    listen_to :channel, method: :on_channel
    def on_channel(msg)
      @brain ||= Brain.new

      options = {
        nickname: msg.user.nick,
         message: msg.message,
         nicknames: msg.channel.users.keys.map(&:nick),
      }
      @brain.botname = msg.bot.nick
      @brain.message(options) do |answer|
        sleep(0.2)
        msg.reply answer
      end
    end
  end

end
