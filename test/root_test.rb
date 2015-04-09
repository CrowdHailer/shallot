require_relative './test_config'

class RootTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    @app ||= Class.new(Shallot::Controller) do
      get '/' do
        response << 'hello'
      end
    end.new
  end

  def teardown
    @app = nil
  end

  def test_returns_root_content
    skip
    get '/'
    assert_equal 'hello', last_response.body
  end

end
