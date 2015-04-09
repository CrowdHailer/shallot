module Shallot
  class PathMatcher
    AbstractMatcherError = Class.new(StandardError)
    class Abstract
      class << self
        def new(*args)
          raise AbstractMatcherError if abstract?
          super
        end

        def abstract?
          !@matcher
        end

        def matcher=(matcher)
          @matcher = matcher
        end

        def matcher
          @matcher
        end

        def for(matcher)
          Class.new(self).tap do |m|
            m.matcher = matcher
          end
        end
      end

      def initialize(submission)
        @submission = submission
      end

      attr_reader :submission

      def match?
        true
      end
    end
  end
end
