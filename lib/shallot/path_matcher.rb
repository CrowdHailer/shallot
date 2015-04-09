module Shallot
  class PathMatcher
    class Abstract
      class << self
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
