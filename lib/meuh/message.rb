module Meuh
  class Message
    attr_reader :text,
                :nickname,
                :botname,
                :nicknames,
                :previous_message,
                :previous_nickname

    def initialize(text:,
                   nickname:,
                   botname:,
                   nicknames:,
                   previous_message:,
                   previous_nickname:)
      @text = text
      @nickname = nickname
      @botname = botname
      @nicknames = nicknames
      @previous_message = previous_message
      @previous_nickname = previous_nickname
    end
  end
end
