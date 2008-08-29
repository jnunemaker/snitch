class Snitch
  module Services
    class Echo < Service
      def tattle(message)
        puts message
      end
    end
  end
end
