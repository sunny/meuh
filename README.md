READMEUH
========

Meuh is a very low artificial intelligence for a very stupid IRC channel bot
companion.

Usage
-----

You can use the `Meuh::CinchPlugin` to create a bot using Cinch:

```rb
require "meuh/cinch_plugin"

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = "Meuh"
    c.server = "irc.freenode.org"
    c.channels = ["##cinch-bots"]
    c.plugins.plugins = [Meuh::CinchPlugin]
  end
end

bot.start
```

Or you can integrate in your own messaging system:

```rb
require "meuh"

bot = MeuhBot.new(botname: "TODO")
bot.message(nickname: "TODO", message: "TODO", nicknames: ["TODO", "TODO"]) do |response|
  puts response
end
```

Usage with the example file
---------------------------

```sh
$ ruby -Ilib bot_example.rb
```
