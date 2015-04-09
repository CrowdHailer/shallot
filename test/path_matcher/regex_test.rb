require_relative '../test_config'

module Shallot
  class RootMatcherTest < MiniTest::Test
    ADMIN_REGEX = %{admin}
    def admin_matcher
      @admin_matcher ||= PathMatchers::Abstract.for(ADMIN_REGEX)
    end

    def teardown
      @admin_matcher = nil
    end

    def test_matches_admin_string
      match = admin_matcher.new('admin')
      assert_equal true, match.match?
    end

    def test_consumes_admin_string
      match = admin_matcher.new('admin')
      assert_equal 'admin', match.consumed
    end

    def test_matches_with_forward_slash
      match = admin_matcher.new('/admin')
      assert_equal true, match.match?
    end

    def test_consumes_with_forward_slash
      match = admin_matcher.new('/admin')
      assert_equal '/admin', match.consumed
    end

    def test_matches_with_trailing_slash
      match = admin_matcher.new('admin/')
      assert_equal true, match.match?
    end

    def test_consumes_with_trailing_slash
      match = admin_matcher.new('admin/')
      assert_equal 'admin/', match.consumed
    end

    def test_does_not_match_random_string
      match = admin_matcher.new('random')
      assert_equal false, match.match?
    end

    def test_does_not_consume_random_string
      match = admin_matcher.new('random')
      assert_equal nil, match.consumed
    end

    def test_does_not_match_when_trailing
      match = admin_matcher.new('admins')
      assert_equal false, match.match?
    end

    def test_consume_when_trailing
      match = admin_matcher.new('admins')
      assert_equal 'admin', match.consumed
    end
  end
end
