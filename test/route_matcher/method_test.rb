require_relative '../test_config'

module Shallot
  class MethodMatchersTest < MiniTest::Test
    def test_can_have_single_method
      matcher = RouteMatcher.for(request_methods: 'GET')
      assert_equal ['GET'], matcher.request_methods
    end

    def test_uses_rack_strings
      puts Rack.release
      matcher = RouteMatcher.for(request_methods: 'GET')
      assert_equal Rack::GET.object_id, matcher.request_methods.first.object_id
    end
  end
end
