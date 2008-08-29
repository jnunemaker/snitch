class Snitch
  module Services
    class Echo < Service
      def initialize(options)
        super(options)
      end
      
      def tattle(message)
        puts message
      end
    end
  end
end
