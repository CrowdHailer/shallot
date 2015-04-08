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
    # def self.http(*http_methods)
    #   ->(request){
    #     http_methods.include? request.request_method ? request : false
    #   }
    # end
    #
    # def self.get(*arguments)
    #   http('GET', *arguments)
    # end
    #
    # def self.segment(regex)
    #   ->(request){
    #     request.match regex
    #   }
    # end
    #
    # def self.on(*conditions, &block)
    #
    # end
    #
    # def respond
    #   new_request = conditions.reduce request.dup do |request, condition|
    #     if request
    #       condition.call(request)
    #     end
    #   end
    #   request = new_request
    # end

    # def routes
    #   settings.routes
    # end

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
