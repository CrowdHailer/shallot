require_relative './test_config'

class RootTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    @app ||= Class.new(Shallot::Controller) do
      get '/' do
        response.body << 'hello'
      end
    end.new
  end

  def teardown
    @app = nil
  end

  def test_returns_root_content
    get '/'
    assert_equal 'hello', last_response.body
  end

  def test_no_match_for_diffent_path
    get '/random'
    assert_equal 404, last_response.status
  end

end
