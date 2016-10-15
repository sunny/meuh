module Meuh
  module Plugins
    class RandomChat
      def answer(msg)
        if rand(0..50).zero?
          [":)", ":p", "lol"].sample
        end
      end
    end
  end
end
