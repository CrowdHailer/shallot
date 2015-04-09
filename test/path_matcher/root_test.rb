require_relative '../test_config'

module Shallot
  class RootMatcherTest < MiniTest::Test
    def root_matcher
      @root_matcher ||= PathMatchers::RootPath
    end

    def teardown
      @root_matcher = nil
    end

    def test_matches_root
      # root_matcher.submit
      match = root_matcher.new('/')
      assert match.match?
    end

    def test_root_match_empty
      match = root_matcher.new('')
      assert match.match?
    end

    def test_root_doesnt_match_with_content
      match = root_matcher.new('/no-match')
      refute match.match?
    end
  end
end
