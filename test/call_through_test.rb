require_relative './test_config'

class BaseTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    @app ||= Class.new(Shallot::Controller).new(downstream)
  end

  def downstream
    @downstream ||= ->(env){[200, {}, ['Test']]}
  end

  def teardown
    @app = nil
    @downstream = nil
  end

  def test_root
    get '/'
    assert last_response.ok?
  end

  def test_makes_app_available
    assert_equal downstream, app.app
  end
end
