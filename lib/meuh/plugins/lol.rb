module Meuh
  module Plugins
    class Lol
      def answer(msg)
        if msg.text =~ /^(lol|lolilol|mdr|rofl|ptdr) ?!*$/i
          ['lol', 'mdr', 'rofl', 'ptdr', 'haha'].sample
        end
      end
    end
  end
end
