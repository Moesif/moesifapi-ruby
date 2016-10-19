

module MoesifApi
  class BaseModel
    # Returns a Hash representation of the current object
    def to_hash
      hash = {}
      self.instance_variables.each do |name|
        value = self.instance_variable_get(name)
        name = name[1..-1]
        key = self.class.names.key?(name) ? self.class.names[name] : name
        if value.instance_of? Array
          hash[key] = value.map{|v| v.kind_of?(BaseModel) ? v.to_hash : v}
        elsif value.instance_of? Hash
          hash[key] = {}
          value.each do |k, v|
            hash[key][k] = v.kind_of?(BaseModel) ? v.to_hash : v
          end
        else
          hash[key] = value.kind_of?(BaseModel) ? value.to_hash : value
        end
      end
      hash
    end

    # Returns a JSON representation of the curent object
    def to_json(options = {})
      hash = to_hash
      hash.to_json(options)
    end
  end
end
