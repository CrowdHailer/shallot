module Shallot
  class PathMatchers
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

      def matcher
        self.class.matcher
      end

      def match?
        !!consumed && !!data.post_match[%r{^/?$}]
      end

      def consumed
        pre_match && pre_match + submission[matcher]
      end

      def data
        submission.match matcher
      end

      def pre_match
        data && data.pre_match
      end

      def post_match
        data && data.post_match
      end

    end

    class RootPath < Abstract
      self.matcher = %r{^/?$}
    end
  end
end
