# frozen_string_literal: true

require 'minitest/autorun'
require_relative './http_server'

class HTTPServerTest < Minitest::Test
  def test_greetings
    assert_equal HTTPServer.greetings, 'Hello, World!'
  end
end
