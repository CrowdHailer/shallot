require_relative '../test_config'

module Shallot
  class PathMatcherTest < MiniTest::Test
    def test_class_is_marked_as_abstract
      assert PathMatcher::Abstract.abstract?
    end

    def test_is_not_abstract_when_has_a_matcher
      root_matcher = PathMatcher::Abstract.for('/')
      refute root_matcher.abstract?
    end

    def test_is_new_class_for_each_matcher
      root_matcher = PathMatcher::Abstract.for('/')
      refute_equal PathMatcher::Abstract, root_matcher
    end
  end
end
