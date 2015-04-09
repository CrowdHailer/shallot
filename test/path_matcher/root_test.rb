require_relative '../test_config'

module Shallot
  class RootMatcherTest < MiniTest::Test
    def root_matcher
      @root_matcher ||= PathMatchers::RootPath
    end

    def teardown
      @root_matcher = nil
    end

    def test_matches_single_slash
      # root_matcher.submit
      match = root_matcher.new('/')
      assert_equal true, match.match?
    end

    def test_consumes_single_slash
      match = root_matcher.new('/')
      assert_equal '/', match.consumed
    end

    def test_matches_empty_string
      match = root_matcher.new('')
      assert_equal true, match.match?
    end

    def test_consumes_empty_string
      match = root_matcher.new('')
      assert_equal '', match.consumed
    end

    def test_root_doesnt_match_with_content
      match = root_matcher.new('/no-match')
      assert_equal false, match.match?
    end

    def test_does_not_consume_when_no_match
      match = root_matcher.new('/no-match')
      assert_nil match.consumed
    end
  end
end
