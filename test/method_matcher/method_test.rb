require_relative '../test_config'

module Shallot
  class MethodMatchersTest < MiniTest::Test
    # string matching
    def test_matches_single_method
      matcher = MethodMatcher.for('GET')
      match = matcher.new('GET')
      assert_equal true, match.match?
    end

    def test_fails_single_method
      matcher = MethodMatcher.for('GET')
      match = matcher.new('POST')
      assert_equal false, match.match?
    end

    def test_makes_rack_requested_method_available
      matcher = MethodMatcher.for('GET')
      match = matcher.new('GET')
      assert_equal Rack::HttpVerb.verb!('get').object_id, match.requested_method.object_id
    end

    # class generation
    def test_can_have_more_than_one_matcher
      matcherA = MethodMatcher.for('GET')
      matcherB = MethodMatcher.for('POST')
      assert_equal ['GET'],  matcherA.request_methods.to_a
      assert_equal ['POST'],  matcherB.request_methods.to_a
    end

    def test_sets_class_name_from_single_method
      matcher = MethodMatcher.for('GET')
      assert_equal 'Shallot::MethodMatcher::GET', matcher.name
    end

    def test_sets_class_name_from_multiple_methods
      matcher = MethodMatcher.for('GET', 'POST')
      assert_equal 'Shallot::MethodMatcher::GET_POST', matcher.name
    end

    def test_sets_class_name_from_multiple_methods_reverse_order
      matcher = MethodMatcher.for('POST', 'GET')
      assert_equal 'Shallot::MethodMatcher::GET_POST', matcher.name
    end

    def test_memoizes_generated_clases
      matcherA = MethodMatcher.for('GET')
      matcherB = MethodMatcher.for('GET')
      assert_equal matcherA, matcherB
    end

    # Setting methods
    def test_can_have_single_method
      matcher = MethodMatcher.for('GET')
      assert_equal ['GET'], matcher.request_methods.to_a
    end

    def test_can_have_multiple_methods
      matcher = MethodMatcher.for('GET', 'POST')
      assert_equal ['GET', 'POST'], matcher.request_methods.to_a
    end

  end
end
