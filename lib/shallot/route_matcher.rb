require 'rack'

module Shallot
  class RouteMatcher
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
      def for(request_methods:)
        inputs = Array request_methods
        request_methods = inputs.map do |verb|
          METHODS.detect { |r_verb| 0 == verb.to_s.casecmp(r_verb) }
        end
        copy = Class.new(self)
        copy.request_methods = request_methods
        copy
      end

      attr_accessor :request_methods
    end

  end
end
