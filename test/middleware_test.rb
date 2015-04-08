require_relative './test_config'

class MiddlewareTest < MiniTest::Test
  include Rack::Test::Methods

  class NoOpMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      env = env.merge 'X-TEST-KEY' => 'new-key'
      a,b,c = @app.call(env)
      b['X-TEST-HEADER'] = 'new-header'
      [a,b,c]
    end
  end

  def app
    mock.expect :report, true, ['new-key']
    @app ||= Class.new(Shallot::Controller) do
      use NoOpMiddleware
    end.new(->(env){
      mock.report env['X-TEST-KEY']
      [200, {}, ['test']]
    })
  end

  def mock
    @mock ||= MiniTest::Mock.new
  end

  def teardown
    @app = nil
    @mock = nil
  end

  def test_middleware_can_add_key_to_env
    get '/'
    mock.verify
  end

  def test_middle_ware_can_modify_response_headers
    get '/'
    assert_equal 'new-header', last_response.headers['X-TEST-HEADER']
  end
end
