require 'tinder'

class Snitch
  module Services
    class Campfire < Service
            
      def connection(force=false)
        if @campfire.nil? || force
          connection = ::Tinder::Campfire.new(subdomain)
          connection.login(login, password)
          raise ServiceLoginError, "Login to Campfire failed" unless connection.logged_in?
          @campfire = connection.find_or_create_room_by_name(room)
        end
        @campfire
      end
      
      def tattle(message)
        connection.paste(message)
      end
    end
  end
end