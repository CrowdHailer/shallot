require 'rack'
require 'set'

module Shallot
  class MethodMatcher
    class Collection
      def initialize(*verbs)
        @set = Set.new(Array(verbs).map{|m| Rack::HttpVerb.verb! m }.sort_by{|x| Rack::HttpVerb::VERBS.index x.to_s})
      end

      def name
        @set.to_a.join('_')
      end

      def to_a
        @set.to_a
      end

      def include?(item)
        @set.include?(item)
      end
    end

    class << self
      def for(*request_methods)
        fetch(Collection.new(*request_methods), &method(:mount_matcher))
      end

      def mount_matcher(request_methods)
        const_set(request_methods.name, build_matcher(request_methods))
      end

      def build_matcher(request_methods)
        new_decendant.tap do |matcher|
          matcher.request_methods = request_methods
        end
      end

      def fetch(request_methods)
        name = request_methods.name
        return const_get name if const_defined? name
        yield request_methods
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
