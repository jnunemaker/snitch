require 'tinder'
module Snitch
  module Services
    # Allows for using tinder the unnofficial campfire api to paste a commit message into a campfire chatroom.
    class Campfire < Service
            
      # Logs into campfire and enters the room in the config file.
      def connection(force=false)
        if @campfire.nil? || force
          connection = ::Tinder::Campfire.new(subdomain)
          connection.login(login, password)
          raise ServiceLoginError, "Login to Campfire failed" unless connection.logged_in?
          @campfire = connection.find_or_create_room_by_name(room)
        end
        @campfire
      end
      
      # Pastes a given message into a campfire room using the connection method.
      def tattle(message)
        connection.paste(message)
      end
    end
  end
end