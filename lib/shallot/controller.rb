module Shallot
  class Controller
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

    def initialize(app)
      @app = app
    end

    attr_reader :app

    def call(env)
      @app.call(:a)
    end


  end
end
