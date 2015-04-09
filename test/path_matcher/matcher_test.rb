require_relative '../test_config'

module Shallot
  class PathMatcherTest < MiniTest::Test
    def test_class_is_marked_as_abstract
      assert PathMatcher::Abstract.abstract?
    end
  end
end
