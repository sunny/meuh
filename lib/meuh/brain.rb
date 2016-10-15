module Meuh
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
