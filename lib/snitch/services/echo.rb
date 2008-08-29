module Snitch
  module Services
    class Echo < Service
      def initialize(*args)
        super(*args)
      end
      
      def tattle(message)
        puts message
      end
    end
  end
end
