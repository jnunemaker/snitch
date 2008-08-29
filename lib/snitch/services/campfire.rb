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
        connection.speak(message, :paste => paste)
      end
    end
  end
end