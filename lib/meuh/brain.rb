# coding: utf-8
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
      @responded = false

      answers = case message
      when /^!/
        return # Do not record this as a previous message

      when /^s\/(.+)\/(.*)\/(i)?$/
        begin
          replacement = $2
          regexp = Regexp.new($1, $3)
          answer = @previous_message.to_s.gsub(regexp, replacement)
          if @previous_message && answer != @previous_message
            yield say answer
          end
        rescue RegexpError
        end

      when /^ping/i
        yield say "pong"

      when /^où\b.*\?$/i
        yield say "dtc"

      when /^qui\b.*\?$/i
        rand_nick = (nicknames - [botname]).sample
        yield say ["C’est #{rand_nick} !", "c'est #{rand_nick}"].sample

      when /\b#{@botname}\b.*\?$/
        rand_nick = (nicknames - [botname]).sample
        yield say ['ouais', 'euh ouais', 'vi', 'affirmatif', 'sans doute',
          "c'est possible", "j'en sais rien moi D:", 'arf, non', 'non', 'nan',
          'euh nan', 'negatif', 'euhh peut-être',
          "demande à #{rand_nick}"].sample

      when /\b#{@botname}\b/
        yield say ['3:-0', 'oui ?', '...', 'lol', 'mdr', ":')",
          'arf', 'shhh', ':)', '3:)', 'tg :k', "moi aussi je t'aime",
          "oui oui #{nickname}"].sample if rand(0..10) > 0

      when /^lu$/i
        yield say ["tin", "stucru", "mière"].sample

      when /^hein ?\?$/i
        yield say ["deux", "deux !!"].sample

      when /^quoi ?\?$/i
        yield say "feur !"

      when /^(lol|mdr|rofl|ptdr) ?!*$/i
        yield say ['lol', 'mdr', 'rofl', 'ptdr', 'haha'].sample

      else
        # Repeat
        if message == @previous_message and @previous_nickname != nickname \
          and @previous_nickname != @botname
          yield say message
        else
          yield say [":)", ":p", "3:)", "lol"].sample if rand(0..50).zero?
        end
      end

      # Remember what the person said
      if !@responded
        @previous_message = message
        @previous_nickname = nickname
      end
    end

    # Return a message and remember that you said something
    def say(message)
      if message
        @previous_message = message
        @previous_nickname = @botname
        @responded = true
        message
      end
    end
  end

end
