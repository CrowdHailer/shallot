require_relative './test_config'

class MapTest < MiniTest::Test
  include Rack::Test::Methods

  FOO = 'foo'
  BAR = 'bar'

  def app
    mock = self.mock
    @app ||= Class.new(Shallot::Controller) do
      map '/foo', ->(env){ [200, {}, [FOO]] }
      map '/bar', &->(env){ [200, {}, [BAR]] }
    end.new
  end

  def mock
    @mock ||= MiniTest::Mock.new
  end

  def teardown
    @app = nil
    @mock = nil
  end

  def test_calls_mapped_sub_app
    get '/foo'
    assert_equal FOO, last_response.body
  end

  def test_calls_proc
    get '/bar'
    assert_equal BAR, last_response.body
  end

  def test_calls_through_when_no_mapping
    get '/other'
    assert_equal 404, last_response.status
  end

  # def test_builder
  #   get '/other'
  #   puts app.builder.to_app.instance_variable_get '@mapping'
  # end
end
