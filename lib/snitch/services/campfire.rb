require 'tinder'

class Snitch
  module Services
    class Campfire < Service
      def connection
        connection = ::Tinder::Campfire.new(subdomain)
        connection.login(login, password)
        connection.find_or_create_room_by_name(room)
      end
      
      def default_options
        super.merge(:paste => true)
      end
      
      def tattle(message)
        # working around Tinder bug: see http://github.com/jqr/tinder/commit/5183567f060c991b7ed9c986b0594f8a53c2be63
        speak_options = {}
        speak_options[:paste] = true if paste
        connection.speak(message, speak_options)
      end
    end
  end
end