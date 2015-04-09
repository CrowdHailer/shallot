require 'rack'

module Shallot
  HTTPMethodUnknown = Class.new(StandardError)
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
      def for(*request_methods)
        request_methods = request_methods.map(&method(:verb!))
        name = request_methods.join('_')
        return get_matcher name if has_matcher? name
        build_matcher request_methods, name
      end

      def build_matcher(request_methods, name)
        const_set(name, new_decendant).tap do |matcher|
          matcher.request_methods = request_methods
        end
      end

      def new_decendant
        Class.new(self)
      end

      def get_matcher(name)
        const_get name
      end

      def has_matcher?(name)
        const_defined? name
      end

      attr_accessor :request_methods

      def verb!(verb)
        get_verb(verb) or unknown_verb(verb)
      end

      def get_verb(verb)
        METHODS.detect { |r_verb| 0 == verb.to_s.casecmp(r_verb) }
      end

      def unknown_verb(verb)
        raise HTTPMethodUnknown, "HTTP method '#{verb}' not recognised"
      end

    end

    def initialize(requested_method)
      @requested_method = matcher.verb!(requested_method)
    end

    attr_reader :requested_method

    def match?
      request_methods.include? requested_method
    end

    def request_methods
      matcher.request_methods
    end

    def matcher
      self.class
    end

  end
end
