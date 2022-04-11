# frozen_string_literal: true

require 'json'
require 'net/http'
require 'minitest/autorun'
require_relative '../src/http_server'

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

# Basic endpoint raising an error (to test error recovery)
class ErrorHandler
  def call(_)
    raise StandardError
  end
end

# Basic endpoint to check that custom `/health` handler work
class HealthHandler
  def call(_)
    [
      200,
      { 'Content-Type' => 'application/json' },
      [JSON.generate({ status: 'pass (test)' })]
    ]
  end
end

describe 'tests related to status code and response body' do
  before(:all) do
    @server = HTTPServer.new('0.0.0.0', 8080)
  end

  after do
    @server.stop
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

  it 'test that server is able to recover from an error and return 500' do
    @server.handle('/bad', ErrorHandler)
    @server.start

    res = Net::HTTP.get_response(URI('http://0.0.0.0:8080/bad'))

    assert_equal Net::HTTPInternalServerError, res.code_type
    assert_equal 'Internal server error', res.body
  end
end

describe 'tests related to the health check' do
  before(:all) do
    @server = HTTPServer.new('0.0.0.0', 8080)
  end

  after do
    @server.stop
  end

  it 'test that server start with a default handler for /health' do
    @server.start

    res = Net::HTTP.get_response(URI('http://0.0.0.0:8080/health'))

    assert_equal Net::HTTPOK, res.code_type
    assert_equal 'pass', JSON.parse(res.body)['status']
  end

  it 'test that the health handler can be override' do
    @server.handle('/health', HealthHandler)
    @server.start

    res = Net::HTTP.get_response(URI('http://0.0.0.0:8080/health'))

    assert_equal Net::HTTPOK, res.code_type
    assert_equal 'pass (test)', JSON.parse(res.body)['status']
  end
end
