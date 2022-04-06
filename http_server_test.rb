# frozen_string_literal: true

require 'minitest/autorun'
require_relative './http_server'

# Required tests for our custom HTTP server
class HTTPServerTest < Minitest::Test
  def test_greetings
    assert_equal HTTPServer.greetings, 'Hello, World!'
  end

  # TCP Socket listening on given port
  # HTTP Server handle a given route
  # HTTP Server send back 404 when route doesn't exist
  # HTTP Server handle fatal errors and returns 500
  # HTTP Server answer on /health by default
  # HTTP Server answer on a given /health endpoint
end
