# frozen_string_literal: true

require 'thin'

# A Thin adapter is the Ruby equivalent of Go's handler
class HelloAdapter
  def call(_env)
    body = ['hello']

    [
      200,
      { 'Content-Type' => 'text/plain' },
      body
    ]
  end
end

Thin::Server.start('0.0.0.0', 3000) do
  use Rack::CommonLogger

  map '/ping' do
    run HelloAdapter.new
  end
end
