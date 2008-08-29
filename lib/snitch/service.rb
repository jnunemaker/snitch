class Snitch
  class Service
    attr_reader :base, :attributes
    
    class << self
      
      def new_from_name(s, attributes)
        "Snitch::Services::#{s.to_s.camelize}".constantize.new(attributes)
      end
    end
    
    def initialize(attributes)
      defaults = { :message_length => :long }
      @attributes = defaults.merge(attributes || {})
    end
    
    def method_missing(method, *args, &block)
      if method.to_s =~ /=$/
        @attributes[method.to_s.chop] = args[0]
      else
        attributes[method.to_s] || attributes[method] || super
      end
    end
  end
end