require "meuh/cinch_plugin"

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = "M3uh"
    c.server = "irc.freenode.org"
    c.channels = ["##cinch-bots"]
    c.plugins.plugins = [Meuh::CinchPlugin]
  end
end

bot.start
