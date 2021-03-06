class Snitch
  class Service
    attr_accessor :attributes
    
    def self.new_from_name(s, attributes)
      "Snitch::Services::#{s.to_s.camelize}".constantize.new(attributes)
    end
    
    def initialize(attributes)
      self.attributes = default_options.merge(attributes || {}).symbolize_keys
    end
    
    def default_options
      { :message_length => :long }
    end
    
    def method_missing(method, *args, &block)
      if attributes.include?(method)
        attributes[method]
      else
        super
      end
    end
  end
end