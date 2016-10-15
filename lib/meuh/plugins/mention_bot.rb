module Meuh
  module Plugins
    class MentionBot
      def answer(msg)
        if msg.text =~ /\b#{msg.botname}\b$/
          ["3:-0", "oui ?", "...", "lol", "mdr", ":')", "arf", "shhh", ":)",
           "3:)", "tg :k", "moi aussi je t'aime",
           "oui oui #{msg.nickname}"].sample
        end
      end
    end
  end
end
