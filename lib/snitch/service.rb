module Snitch
  # Service is the base class for all services. All services should inherit from this class.
  class Service
    attr_reader :base, :attributes
    
    class << self
      
      # Handy for creating a new instance of a service from the config file. Simply pass in the service name and the attributes for the service and you get a new instance of the service.
      #
      #   Snitch::Service.new_from_name(:twitter, {:login => 'jnunemaker', :password => 'secret'})
      #   # => #<Snitch::Services::Twitter:0x15a6508 @attributes={:login=>"jnunemaker", :password=>"secret"}>
      def new_from_name(s, attributes)
        service = "Snitch::Services::#{s.to_s.camelize}".constantize
        service.new(attributes)
      end
    end
    
    def initialize(attributes = {})
      @attributes = attributes
    end
    
    # Uses method missing to return the value of a key in the attributes hash.
    # Allows for doing this...
    #
    #   service.login
    #
    # instead of this...
    #
    #   service.attributes[:login]
    def method_missing(method, *args, &block)
      if method.to_s =~ /=$/
        @attributes[method.to_s.chop] = args[0]
      else
        attributes[method.to_s] || attributes[method] || super
      end
    end
  end
end