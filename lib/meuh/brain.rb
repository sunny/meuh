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
      answers = case message
      when /^!/
        return
      when /^où.*\?$/
        yield "dtc"
      when /#{@botname}.*\?$/
        rand_nick = (nicknames - [botname]).sample
        yield ['ouais', 'euh ouais', 'vi', 'affirmatif', 'sans doute',
          "c'est possible", "j'en sais rien moi D:", 'arf, non', 'non', 'nan',
          'euh nan', 'negatif', 'euhh peut-être',
          "demande à #{rand_nick}"].sample
      when /#{@botname}/
        yield ['3:-0', '', 'oui ?', '...', 'lol', 'mdr', ":')",
          'arf', 'shhh', ':)', '3:)', 'tg :k', "moi aussi je t'aime",
          "oui oui #{nickname}"].sample
      when /^lu$/
        yield ["tin", "stucru"].sample
      when /^hein ?\?$/
        yield "deux !!"
      when /^quoi ?\?$/
        yield "feur !"
      when /^qui\b/
        rand_nick = (nicknames - [botname]).sample
        yield "C’est #{rand_nick} !"
      when /^(lol|mdr|rofl|ptdr) ?!*$/i
        yield ['lol','mdr','rofl','ptdr'].sample
      else
        if message == @previous_message and @previous_nickname != nickname
          @previous_message = nil
          @previous_nickname = nil
          yield message
        else
          @previous_message = message
          @previous_nickname = nickname
          yield [":)", ":p", "3:)", "lol"].sample if rand(0..50).zero?
        end
      end
    end
  end
end
