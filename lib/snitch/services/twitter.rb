require 'twitter'

class Snitch
  module Services
    class Twitter < Service
      
      def initialize(attributes = {})
        super({ :message_length => :short }.merge(attributes))
      end
      
      def connection
        ::Twitter::Base.new(login, password)
      end
      
      def tattle(message)
        connection.update(message)
      end
    end
  end
end