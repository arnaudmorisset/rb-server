# frozen_string_literal: true

require 'net/http'
require 'minitest/autorun'
require_relative './http_server'

# Basic endpoint returning status code 200 and body 'OK!'
class PingHandler
  def call(_)
    [
      200,
      {},
      ['OK!']
    ]
  end
end

# Required tests for our custom HTTP server
describe 'functionnal test for our custom HTTP server' do
  before(:all) do
    @server = HTTPServer.new('0.0.0.0', 8080)
    @server.server.silent = true
    @server.handle('/ping', PingHandler)
  end

  after(:all) do
    @server.stop
  end

  it 'test that server is listening on given port' do
    @server.start

    # No need for assertion as this call will raise an exception
    # if Net library is unable to open a TCP client socket
    # on the given domain:port address.
    Net::HTTP.get('0.0.0.0', '/', 8080)
  end
end

# HTTP Server handle a given route
# HTTP Server send back 404 when route doesn't exist
# HTTP Server handle fatal errors and returns 500
# HTTP Server answer on /health by default
# HTTP Server answer on a given /health endpoint
