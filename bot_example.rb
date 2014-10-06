require "meuh/cinch_plugin"

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = "M3uh_"
    c.server = "irc.freenode.org"
    c.channels = ["##agencecosmic2"]
    c.plugins.plugins = [Meuh::CinchPlugin]
  end
end

bot.start
