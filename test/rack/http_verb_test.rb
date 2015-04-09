require_relative '../test_config'
require 'rack'

module Rack
  class HttpVerbTest < MiniTest::Test
    def test_memory_of_verbs
      matcherA = HttpVerb.verb!('GET')
      matcherB = HttpVerb.verb!('GET')
      assert_equal matcherA.object_id, matcherB.object_id
    end
    def test_raises_error_for_unknown_method
      assert_raises Rack::HttpVerb::VerbUnknown do
        HttpVerb.verb!('TICKLE')
      end
    end

    def test_include_method_name_in_error_message
      begin
        HttpVerb.verb!('TICKLE')
      rescue Rack::HttpVerb::VerbUnknown => err
        assert_includes err.message, 'TICKLE'
      end
    end

    def test_uses_rack_get
      verb = HttpVerb.verb!('GET')
      assert_equal Rack::GET.object_id, verb.to_s.object_id
    end

    def test_is_case_insensitive
      verb = HttpVerb.verb!('get')
      assert_equal Rack::GET.object_id, verb.to_s.object_id
    end

    def test_can_use_symbol
      verb = HttpVerb.verb!(:get)
      assert_equal Rack::GET.object_id, verb.to_s.object_id
    end

    def test_uses_rack_post
      verb = HttpVerb.verb!('POST')
      assert_equal Rack::POST.object_id, verb.to_s.object_id
    end

    def test_uses_rack_put
      verb = HttpVerb.verb!('PUT')
      assert_equal Rack::PUT.object_id, verb.to_s.object_id
    end

    def test_uses_rack_patch
      verb = HttpVerb.verb!('PATCH')
      assert_equal Rack::PATCH.object_id, verb.to_s.object_id
    end

    def test_uses_rack_delete
      verb = HttpVerb.verb!('DELETE')
      assert_equal Rack::DELETE.object_id, verb.to_s.object_id
    end

    def test_uses_rack_options
      verb = HttpVerb.verb!('OPTIONS')
      assert_equal Rack::OPTIONS.object_id, verb.to_s.object_id
    end

    def test_uses_rack_link
      verb = HttpVerb.verb!('LINK')
      assert_equal Rack::LINK.object_id, verb.to_s.object_id
    end

    def test_uses_rack_unlink
      verb = HttpVerb.verb!('UNLINK')
      assert_equal Rack::UNLINK.object_id, verb.to_s.object_id
    end

    def test_uses_rack_trace
      verb = HttpVerb.verb!('TRACE')
      assert_equal Rack::TRACE.object_id, verb.to_s.object_id
    end
  end
end
