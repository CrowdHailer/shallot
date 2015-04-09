require 'rack'

module Shallot
  class MethodMatcher
    METHODS = [
      Rack::GET,
      Rack::POST,
      Rack::PUT,
      Rack::PATCH,
      Rack::DELETE,
      Rack::HEAD,
      Rack::OPTIONS,
      Rack::LINK,
      Rack::UNLINK,
      Rack::TRACE
    ]
    class << self
      def for(request_methods)
        inputs = Array request_methods
        request_methods = inputs.map do |verb|
          METHODS.detect { |r_verb| 0 == verb.to_s.casecmp(r_verb) }
        end
        name = request_methods.join('_')
        return self.const_get name if self.const_defined? name
        copy = Class.new(self)
        self.const_set name, copy
        copy.request_methods = request_methods
        copy
      end

      attr_accessor :request_methods
    end

    def initialize(request_method)
      @request_method = METHODS.detect { |r_verb| 0 == request_method.to_s.casecmp(r_verb) }
    end

    attr_reader :request_method

    def match?
      self.class.request_methods.include? @request_method
    end

  end
end
