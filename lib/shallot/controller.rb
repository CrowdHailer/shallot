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

    def call(env)
      self.class.mappings.each do |item|
        builder.map item[0] do
          run item[1]
        end
      end
      self.class.middlewares.each do |middleware|
        builder.use middleware
      end
      builder.run ->(env){
        self.invoke(env)
      }
      builder.call(env)
    end

    def invoke(env)
      if route = self.class.routes.first
        instance_exec &route.last
        response
      else
        app.call(env)
      end
    end

    def response
      @response ||= Rack::Response.new
    end


    def builder
      @builder ||= Rack::Builder.new
    end
  end
end
