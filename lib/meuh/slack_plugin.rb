require "meuh"

module Meuh
  module SlackPlugin
    def self.extended(base)
      base.class_eval do
        @@meuh = Meuh::Brain.new

        match /^.*$/ do |client, data, match|
          channel = client.channels[data.channel]
          members = channel && channel.members || []

          message = {
            nickname: client.users[data.user].name,
            message: match[0],
            nicknames: members.map { |member| client.users[member].name }
          }

          @@meuh.botname = client.name
          @@meuh.message(message) do |response|
            client.say(channel: data.channel, text: response)
          end
        end
      end
    end
  end
end
