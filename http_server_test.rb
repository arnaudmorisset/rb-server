# frozen_string_literal: true

require 'net/http'
require 'minitest/autorun'
require_relative './http_server'

# Basic endpoint returning status code 200 and body 'OK!'
class PingHandler
  def call(_)
    [
      200,
      { 'Content-Type' => 'text/plain' },
      ['OK!']
    ]
  end
end

# Required tests for our custom HTTP server
describe 'functional test for our custom HTTP server' do
  before(:all) do
    @server = HTTPServer.new('0.0.0.0', 8080)
  end

  after do
    @server.stop
  end

  it 'test that server is listening on given port' do
    @server.start

    # No need for assertion as this call will raise an exception
    # if Net library is unable to open a TCP client socket
    # on the given domain:port address.
    Net::HTTP.get('0.0.0.0', '/', 8080)
  end

  it 'test that server is able to handle a given route' do
    @server.handle('/ping', PingHandler)
    @server.start

    res = Net::HTTP.get_response(URI('http://0.0.0.0:8080/ping'))

    assert_equal Net::HTTPOK, res.code_type
    assert_equal 'OK!', res.body
  end

  it 'test that server return NOT FOUND when route doesn\'t exist' do
    @server.start

    res = Net::HTTP.get_response(URI('http://0.0.0.0:8080/ping'))

    assert_equal Net::HTTPNotFound, res.code_type
    assert_equal 'Not Found: /ping', res.body
  end
end

# HTTP Server handle fatal errors and returns 500
# HTTP Server answer on /health by default
# HTTP Server answer on a given /health endpoint
