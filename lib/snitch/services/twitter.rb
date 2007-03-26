require 'twitter'
module Snitch
  module Services
    # Allows for using the twitter api to post a commit message update.
    class Twitter < Service
      
      # Sets the prefferred commit message length to <tt>:short</tt>
      self.message_length = :short
      
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