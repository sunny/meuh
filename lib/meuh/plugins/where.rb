module Meuh
  module Plugins
    class Where
      def answer(msg)
        if msg.text =~ /^où\b.*\?$/i
          "dtc"
        end
      end
    end
  end
end
