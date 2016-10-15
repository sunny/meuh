module Meuh
  module Plugins
    class Repeat
      def answer(msg)
        if msg.text == msg.previous_message \
           and msg.previous_nickname != msg.nickname \
           and msg.previous_nickname != msg.botname
          msg.text
        end
      end
    end
  end
end
