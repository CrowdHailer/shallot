require 'rack'

module Shallot
  class MethodMatcher
    class << self
      def for(*request_methods)
        request_methods = request_methods.map{|m| Rack::HttpVerb.verb! m }
        fetch(request_methods, &method(:mount_matcher))
      end

      def mount_matcher(request_methods, name)
        const_set(name, build_matcher(request_methods, name))
      end

      def build_matcher(request_methods, name)
        new_decendant.tap do |matcher|
          matcher.request_methods = request_methods
        end
      end

      def fetch(request_methods)
        name = request_methods.join('_')
        return const_get name if const_defined? name
        yield request_methods, name
      end

      def new_decendant
        Class.new(self)
      end

      attr_accessor :request_methods
    end

    def initialize(requested_method)
      @requested_method = Rack::HttpVerb.verb!(requested_method)
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
