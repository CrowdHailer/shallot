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
  end
end
