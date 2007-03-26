class Hash
  def symbolize_keys!
    keys.each do |key|
      unless key.is_a?(Symbol)
        self[key.to_sym] = self[key]
        delete(key)
      end
    end
    self
  end
end