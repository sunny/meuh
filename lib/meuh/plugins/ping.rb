module Meuh
  module Plugins
    class Ping
      def answer(msg)
        if msg.text =~ /^ping$/i
          "pong"
        end
      end
    end
  end
end
