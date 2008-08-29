require 'tinder'

class Snitch
  module Services
    class Campfire < Service
            
      def connection
        connection = ::Tinder::Campfire.new(subdomain)
        connection.login(login, password)
        raise ServiceLoginError, "Login to Campfire failed" unless connection.logged_in?
        connection.find_or_create_room_by_name(room)
      end
      
      def tattle(message)
        connection.paste(message)
      end
    end
  end
end