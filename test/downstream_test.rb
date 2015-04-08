require_relative './test_config'

class DownstreamTest < MiniTest::Test
  include Rack::Test::Methods

  OK_RESPONSE = [200, {}, ['Test']]

  def app
    @app ||= Class.new(Shallot::Controller).new(downstream)
  end

  def downstream
    @downstream ||= ->(env){ OK_RESPONSE }
  end

  def teardown
    @app = nil
    @downstream = nil
  end

  def test_returns_down_stream_response_if_no_matching_route
    get '/'
    assert last_response.ok?
    assert_equal 'Test', last_response.body
  end

  def test_makes_app_available
    assert_equal downstream, app.app
  end
end
