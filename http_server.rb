# frozen_string_literal: true

# Custom HTTP server for any kind of request
# that shouldn't go through the API gateway.
class HTTPServer
  class << self
    def greetings
      'Hello, World!'
    end
  end
end
