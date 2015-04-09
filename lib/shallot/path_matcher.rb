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
    end
  end
end
