# frozen_string_literal: true

require 'thin'

# Custom HTTP server for any kind of request
# that shouldn't go through the API gateway.
class HTTPServer
  attr_reader :domain, :port, :server

  def initialize(domain, port)
    @port = port
    @domain = domain
    @url_map = {}
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
