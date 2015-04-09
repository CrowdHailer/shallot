require_relative '../test_config'

module Shallot
  class MethodMatchersTest < MiniTest::Test
    def test_can_have_more_than_one_matcher
      matcherA = MethodMatcher.for(request_methods: 'GET')
      matcherB = MethodMatcher.for(request_methods: 'POST')
      assert_equal ['GET'],  matcherA.request_methods
      assert_equal ['POST'],  matcherB.request_methods
    end

    def test_sets_class_name_from_single_method
      matcher = MethodMatcher.for(request_methods: 'GET')
      assert_equal 'Shallot::MethodMatcher::GET', matcher.name
    end

    def test_sets_class_name_from_multiple_methods
      matcher = MethodMatcher.for(request_methods: ['GET', 'POST'])
      assert_equal 'Shallot::MethodMatcher::GET_POST', matcher.name
    end

    def test_memoizes_generated_clases
      matcherA = MethodMatcher.for(request_methods: 'GET')
      matcherB = MethodMatcher.for(request_methods: 'GET')
      assert_equal matcherA, matcherB
    end

    # Setting methods
    def test_can_have_single_method
      matcher = MethodMatcher.for(request_methods: 'GET')
      assert_equal ['GET'], matcher.request_methods
    end

    def test_can_have_multiple_methods
      matcher = MethodMatcher.for(request_methods: ['GET', 'POST'])
      assert_equal ['GET', 'POST'], matcher.request_methods
    end

    def test_uses_rack_get
      matcher = MethodMatcher.for(request_methods: 'GET')
      assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    end

    def test_is_case_insensitive
      matcher = MethodMatcher.for(request_methods: 'get')
      assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    end

    def test_can_use_symbol
      matcher = MethodMatcher.for(request_methods: :get)
      assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_post
      matcher = MethodMatcher.for(request_methods: 'POST')
      assert_equal Rack::POST.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_put
      matcher = MethodMatcher.for(request_methods: 'PUT')
      assert_equal Rack::PUT.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_patch
      matcher = MethodMatcher.for(request_methods: 'PATCH')
      assert_equal Rack::PATCH.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_delete
      matcher = MethodMatcher.for(request_methods: 'DELETE')
      assert_equal Rack::DELETE.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_options
      matcher = MethodMatcher.for(request_methods: 'OPTIONS')
      assert_equal Rack::OPTIONS.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_link
      matcher = MethodMatcher.for(request_methods: 'LINK')
      assert_equal Rack::LINK.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_unlink
      matcher = MethodMatcher.for(request_methods: 'UNLINK')
      assert_equal Rack::UNLINK.object_id, matcher.request_methods.first.object_id
    end

    def test_uses_rack_trace
      matcher = MethodMatcher.for(request_methods: 'TRACE')
      assert_equal Rack::TRACE.object_id, matcher.request_methods.first.object_id
    end

  end
end
