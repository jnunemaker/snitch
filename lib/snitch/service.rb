class Snitch
  class Service
    attr_accessor :base, :attributes
    
    def self.new_from_name(s, attributes)
      "Snitch::Services::#{s.to_s.camelize}".constantize.new(attributes)
    end
    
    def initialize(attributes)
      self.attributes = default_options.merge(attributes || {})
    end
    
    def default_options
      { :message_length => :long }
    end
    
    def method_missing(method, *args, &block)
      if method.to_s =~ /=$/
        self.attributes[method.to_s.chop] = args[0]
      else
        attributes[method.to_s] || attributes[method] || super
      end
    end
  end
end