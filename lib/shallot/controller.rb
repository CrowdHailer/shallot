module Shallot
  class Controller
    class << self
      def map *args
        mappings.push args
      end

      def mappings
        @mappings ||= []
      end
    end

    def initialize(app = ->(env){ [404, {}, ['Not Found']] })
      @app = app
    end

    attr_reader :app

    def call(env)
      builder = Rack::Builder.new
      self.class.mappings.each do |item|
        builder.map item[0] do
          run item[1]
        end
      end
      builder.run app
      builder.call(env)
    end


  end
end
