require_relative './test_config'

class BaseTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    ->(env){
      puts env['REQUEST_METHOD'].object
      [200, {}, ['h']]
    }
  end

  def test_root
    get '/',{}
  end
end
