module Rack
  class HttpVerb < SimpleDelegator
    VerbUnknown = Class.new(StandardError)
    VERBS = [
      Rack::GET,
      Rack::POST,
      Rack::PUT,
      Rack::PATCH,
      Rack::DELETE,
      Rack::HEAD,
      Rack::OPTIONS,
      Rack::LINK,
      Rack::UNLINK,
      Rack::TRACE
    ]

    class << self
      def verb!(string)
        memory[rack_verb!(string)]
      end

      def new(string)
        super rack_verb!(string)
      end

      private

      def memory
        @memory ||= Hash.new do |mem, key|
          mem[key] = new(key)
        end
      end

      def rack_verb!(string)
        rack_verb(string) or unknown_verb(string)
      end

      def rack_verb(string)
        VERBS.detect { |r_verb| 0 == string.to_s.casecmp(r_verb) }
      end

      def unknown_verb(string)
        raise VerbUnknown, "HTTP method '#{string}' not recognised"
      end

    end

  end
end
