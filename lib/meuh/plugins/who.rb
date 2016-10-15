module Meuh
  module Plugins
    class Who
      def answer(msg)
        if msg.text =~ /^qui\b.*\?$/i
          rand_nick = (msg.nicknames - [msg.botname]).sample
          ["C’est #{rand_nick} !", "c'est #{rand_nick}"].sample
        end
      end
    end
  end
end
