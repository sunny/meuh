module Meuh
  module Plugins
    class What
      def answer(msg)
        case msg.text
        when /^hein ?\?$/i
          ["deux", "deux !!"].sample

        when /^quoi ?\?$/i
          "feur !"
        end
      end
    end
  end
end
