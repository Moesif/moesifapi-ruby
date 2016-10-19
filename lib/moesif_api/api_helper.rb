

module MoesifApi
  class APIHelper
    # Replaces template parameters in the given url
    # @param [String] The query string builder to replace the template parameters
    # @param [Array] The parameters to replace in the url
    def self.append_url_with_template_parameters(query_builder, parameters)
      # perform parameter validation
      raise ArgumentError, 'Given value for parameter \"query_builder\" is invalid.' unless query_builder.instance_of? String

      # return if there are no parameters to replace
      if parameters.nil?
        query_builder
      else
        # iterate and append parameters
        parameters.each do |key, value|
          replace_value = ''

          if value.nil?
            replace_value = ''
          elsif value.instance_of? Array
            value.map!{|element| CGI.escape(element.to_s)}
            replace_value = value.join('/')
          else
            replace_value = CGI.escape(value.to_s)
          end

          # find the template parameter and replace it with its value
          query_builder = query_builder.gsub('{' + key.to_s + '}', replace_value)
        end
      end
      return query_builder
    end

    # Appends the given set of parameters to the given query string
    # @param [String] The query string builder to replace the template parameters
    # @param [Array] The parameters to append
    def self.append_url_with_query_parameters(query_builder, parameters)
      # perform parameter validation
      raise ArgumentError, 'Given value for parameter \"query_builder\" is invalid.' unless query_builder.instance_of? String

      # return if there are no parameters to replace
      if parameters.nil?
        return query_builder
      else
        # remove any nil values
        parameters = parameters.reject { |_key, value| value.nil? }

        # does the query string already has parameters
        has_params = query_builder.include? '?'
        separator = has_params ? '&' : '?'

        # append query with separator and parameters and return
        return query_builder << separator << URI.encode_www_form(parameters)
      end
    end

    # Validates and processes the given Url
    # @param [String] The given Url to process
    # @return [String] Pre-processed Url as string
    def self.clean_url(url)
      # perform parameter validation
      raise ArgumentError, 'Invalid Url.' unless url.instance_of? String

      # ensure that the urls are absolute
      matches = url.match(%r{^(https?:\/\/[^\/]+)})
      raise ArgumentError, 'Invalid Url format.' if matches.nil?

      # get the http protocol match
      protocol = matches[1]
      
      # check if parameters exist
      index = url.index('?')

      # remove redundant forward slashes
      query = url[protocol.length...(index != nil ? index : url.length)]
      query.gsub!(%r{\/\/+}, '/')

      # get the parameters
      parameters = index != nil ? url[url.index('?')...url.length] : ""

      # return processed url
      return protocol + query  + parameters
    end	

    # Parses JSON string.
    # @param [String] A JSON string.
    def self.json_deserialize(json)
      begin
        return JSON.parse(json)
      rescue
        raise TypeError, "Server responded with invalid JSON."
      end
    end

    # Form encodes a hash of parameters.
    # @param [Hash] The hash of parameters to encode.
    # @return [Hash] A hash with the same parameters form encoded.
    def self.form_encode_parameters(form_parameters)
      encoded = Hash.new
      form_parameters.each do |key, value|
        encoded.merge!(APIHelper.form_encode value, key)
      end 
      return encoded
    end

    # Form encodes an object.
    # @param [Dynamic] An object to form encode.
    # @param [String] The name of the object.
    # @return [Hash] A form encoded representation of the object in the form of a hash.
    def self.form_encode(obj, instance_name)
      retval = Hash.new

      # If this is a structure, resolve it's field names.
      if obj.kind_of? BaseModel
        obj = obj.to_hash
      end
      
      # Create a form encoded hash for this object.
      if obj == nil
        nil         
      elsif obj.instance_of? Array
        obj.each_with_index do |value, index|
          retval.merge!(APIHelper.form_encode(value, instance_name + "[" + index.to_s + "]"))
        end
      elsif obj.instance_of? Hash
        obj.each do |key, value|
          retval.merge!(APIHelper.form_encode(value, instance_name + "[" + key + "]"))
        end
      else
        retval[instance_name] = obj
      end
      return retval
    end
  end
end

# extend types to support to_bool
module ToBoolean
  def to_bool
    return true if self == true || self.to_s.strip =~ /^(true|yes|y|1)$/i
    return false
  end
end

class NilClass; include ToBoolean; end
class TrueClass; include ToBoolean; end
class FalseClass; include ToBoolean; end
class Numeric; include ToBoolean; end
class String; include ToBoolean; end