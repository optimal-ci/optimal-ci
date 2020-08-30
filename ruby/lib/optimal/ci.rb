require 'rest_client'
require 'json'
require "optimal/ci/version"
require "optimal/ci/runner"
require "optimal/ci/queue"
require "rspec/optimal/runner"
require "optimal/ci/provider"
require "optimal/ci/provider/base"
require "optimal/ci/provider/travis"
require "optimal/ci/provider/circle"


module Optimal
  module CI
    class Error < StandardError; end
    # Your code goes here...
  end
end
