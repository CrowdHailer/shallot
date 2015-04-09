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
      assert_equal ['GET'],  matcherA.request_methods
      assert_equal ['POST'],  matcherB.request_methods
    end

    def test_sets_class_name_from_single_method
      matcher = MethodMatcher.for('GET')
      assert_equal 'Shallot::MethodMatcher::GET', matcher.name
    end
    #
    # def test_sets_class_name_from_multiple_methods
    #   matcher = MethodMatcher.for('GET', 'POST')
    #   assert_equal 'Shallot::MethodMatcher::GET_POST', matcher.name
    # end
    #
    # def test_raises_error_for_unknown_method
    #   assert_raises Shallot::HTTPMethodUnknown do
    #     matcher = MethodMatcher.for('TICKLE')
    #   end
    # end
    #
    # def test_include_method_name_in_error_message
    #   begin
    #     matcher = MethodMatcher.for('TICKLE')
    #   rescue Shallot::HTTPMethodUnknown => err
    #     assert_includes err.message, 'TICKLE'
    #   end
    # end
    #
    # def test_memoizes_generated_clases
    #   matcherA = MethodMatcher.for('GET')
    #   matcherB = MethodMatcher.for('GET')
    #   assert_equal matcherA, matcherB
    # end
    #
    # # Setting methods
    # def test_can_have_single_method
    #   matcher = MethodMatcher.for('GET')
    #   assert_equal ['GET'], matcher.request_methods
    # end
    #
    # def test_can_have_multiple_methods
    #   matcher = MethodMatcher.for('GET', 'POST')
    #   assert_equal ['GET', 'POST'], matcher.request_methods
    # end
    #
    # def test_uses_rack_get
    #   matcher = MethodMatcher.for('GET')
    #   assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_is_case_insensitive
    #   matcher = MethodMatcher.for('get')
    #   assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_can_use_symbol
    #   matcher = MethodMatcher.for(:get)
    #   assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_post
    #   matcher = MethodMatcher.for('POST')
    #   assert_equal Rack::POST.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_put
    #   matcher = MethodMatcher.for('PUT')
    #   assert_equal Rack::PUT.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_patch
    #   matcher = MethodMatcher.for('PATCH')
    #   assert_equal Rack::PATCH.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_delete
    #   matcher = MethodMatcher.for('DELETE')
    #   assert_equal Rack::DELETE.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_options
    #   matcher = MethodMatcher.for('OPTIONS')
    #   assert_equal Rack::OPTIONS.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_link
    #   matcher = MethodMatcher.for('LINK')
    #   assert_equal Rack::LINK.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_unlink
    #   matcher = MethodMatcher.for('UNLINK')
    #   assert_equal Rack::UNLINK.object_id, matcher.request_methods.first.object_id
    # end
    #
    # def test_uses_rack_trace
    #   matcher = MethodMatcher.for('TRACE')
    #   assert_equal Rack::TRACE.object_id, matcher.request_methods.first.object_id
    # end

  end
end
