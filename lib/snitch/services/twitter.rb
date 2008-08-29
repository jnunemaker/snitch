require 'twitter'

class Snitch
  module Services
    # Allows for using the twitter api to post a commit message update.
    class Twitter < Service
      
      def initialize(attributes = {})
        super({ :message_length => :short }.merge(attributes))
      end
      
      # Logs into twitter.
      def connection(force=false)
        @twitter = ::Twitter::Base.new(login, password) if @twitter.nil? || force
        @twitter
      end
      
      # Posts a given message to twitter using the connection method.
      def tattle(message)
        connection.update(message)
      end
    end
  end
end