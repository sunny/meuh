module Meuh
  module Plugins
    class QuestionToBot
      def answer(msg)
        if msg.text =~ /\b#{msg.botname}\b.*\?$/
          rand_nick = (msg.nicknames - [msg.botname]).sample
          ['ouais', 'euh ouais', 'vi', 'affirmatif', 'sans doute',
            "c'est possible", "j'en sais rien moi D:", 'arf, non', 'non', 'nan',
            'euh nan', 'negatif', 'euhh peut-être',
            "demande à #{rand_nick}"].sample
        end
      end
    end
  end
end
