module Meuh
  module Plugins
    class Replace
      def answer(msg)
        if msg.text =~ /^s\/(.+)\/(.*)\/(i)?$/
          replacement = $2
          regexp = Regexp.new($1, $3)
          answer = msg.previous_message.to_s.gsub(regexp, replacement)

          if msg.previous_message && answer != msg.previous_message
            answer
          end
        end
      rescue RegexpError
      end
    end
  end
end
