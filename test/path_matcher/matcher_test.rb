require_relative '../test_config'

module Shallot
  class PathMatchersTest < MiniTest::Test

    def test_class_is_marked_as_abstract
      assert PathMatchers::Abstract.abstract?
    end

    def test_subclass_marked_abstract
      assert Class.new(PathMatchers::Abstract).abstract?
    end

    def test_cannot_initialize_abstract_class
      assert_raises PathMatchers::AbstractMatcherError do
        PathMatchers::Abstract.new('/')
      end
    end

    def test_is_not_abstract_when_has_a_matcher
      root_matcher = PathMatchers::Abstract.for('/')
      refute root_matcher.abstract?
    end

    def test_is_new_class_for_each_matcher
      root_matcher = PathMatchers::Abstract.for('/')
      refute_equal PathMatchers::Abstract, root_matcher
    end

    def test_keeps_submission
      match = PathMatchers::Abstract.for('/').new('/')
      assert_equal '/', match.submission
    end


  end
end
