module Shallot
  class Controller
    class << self
      def map(path, sub_app=nil, &block)
        mappings.push [path, sub_app || block]
      end

      def mappings
        @mappings ||= []
      end

      def use(middleware)
        middlewares.push middleware
      end

      def middlewares
        @middleware ||= []
      end

      def routes
        @routes ||= []
      end

      def get(path, &block)
        @routes = [[path, block]]
      end
    end

    def initialize(app = ->(env){ [404, {}, ['Not Found']] })
      @app = app
    end

    attr_reader :app
    attr_accessor :request, :response

    def new(request, response)
      clone.tap do |copy|
        copy.request = request
        copy.response = response
      end
    end

    def call(env)
      new(Rack::Request.new(env), Rack::Response.new).respond

    end

    def invoke(env)
      if route = self.class.routes.first
        condition = route.first
        if condition == env['PATH_INFO']
          instance_exec &route.last
          response
        else
          app.call(env)
        end
      else
        app.call(env)
      end
    end

    def respond
      builder.run ->(env){
        self.invoke(env)
      }
      builder.call(request.env)
    end

    def routes
      self.class.routes
    end

    def response
      @response ||= Rack::Response.new
    end

    def builder
      @builder ||= setup(Rack::Builder.new)
    end

    def setup(builder)
      self.class.mappings.each do |path, sub_app|
        builder.map path do
          run sub_app
        end
      end
      self.class.middlewares.each do |middleware|
        builder.use middleware
      end
      builder
    end
  end
end
