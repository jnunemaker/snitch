require 'twitter'

class Snitch
  module Services
    class Twitter < Service
      def initialize(options = {})
        super
      end

      def default_options
        super.merge(:message_length => :short)
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