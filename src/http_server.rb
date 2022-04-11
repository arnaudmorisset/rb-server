# frozen_string_literal: true

require 'thin'

# Default handler for `/health`
class DefaultHealthHandler
  def call(_)
    [
      200,
      { 'Content-Type' => 'application/json' },
      [JSON.generate({ status: 'pass' })]
    ]
  end
end

# Custom HTTP server for any kind of request
# that shouldn't go through the API gateway.
class HTTPServer
  attr_reader :domain, :port, :server

  def initialize(domain, port)
    @port = port
    @domain = domain
    @url_map = { '/health' => DefaultHealthHandler.new }
  end

  def handle(path, handler)
    @url_map[path] = handler.new
  end

  def start
    @server = Thin::Server.new(domain, 8080, Rack::URLMap.new(@url_map))
    @server.silent = true
    @thread = Thread.new { @server.start }
    sleep(0.5) until @server.running?
  end

  def stop
    @server.stop
    @thread.exit
  end
end
