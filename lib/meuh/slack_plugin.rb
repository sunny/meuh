require "meuh"

module Meuh
  module SlackPlugin
    def self.extended(base)
      base.class_eval do
        @@meuh = Meuh::Brain.new

        match /^.*$/ do |client, data, match|
          message = SlackPlugin.message(client, data, match)
          @@meuh.botname = client.name
          @@meuh.message(message) do |response|
            client.say(channel: data.channel, text: response)
          end
        end
      end
    end

    def self.message(client, data, match)
      nickname = client.users[data.user].name

      text = match[0]
      text = text.gsub("<@#{client.self.id}>", client.name)
      text = text.gsub(":slightly_smiling_face:", ":)")
      text = text.gsub(":smile:", ":D")
      text = text.gsub(":wink:", ";)")
      text = Slack::Messages::Formatting.unescape(text)

      channel = client.channels[data.channel]
      members = channel && channel.members || []
      nicknames = members.map { |member| client.users[member].name }

      puts "-" * 25
      p(
        nickname: nickname,
        message: text,
        nicknames: nicknames
      )
    end
  end
end
