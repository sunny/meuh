module Meuh
  module Plugins
    class Lu
      def answer(msg)
        if msg.text =~ /^lu$/i
          ["tin", "stucru", "mière"].sample
        end
      end
    end
  end
end
