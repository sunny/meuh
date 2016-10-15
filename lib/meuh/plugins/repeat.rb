module Meuh
  module Plugins
    class Repeat
      def answer(msg)
        if msg.text == msg.previous_message \
           and msg.previous_nickname != msg.nickname \
           and msg.previous_nickname != msg.botname
          msg.text
        elsif rand(0..50).zero?
          [":)", ":p", "3:)", "lol"].sample
        end
      end
    end
  end
end
