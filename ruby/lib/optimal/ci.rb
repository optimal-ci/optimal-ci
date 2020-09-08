require 'rest_client'
require 'json'
require 'rspec/core'
require "optimal/ci/version"
require "optimal/ci/runner"
require "optimal/ci/queue"
require "rspec/optimal/runner"
require "optimal/ci/provider"
require "optimal/ci/logger"
require "optimal/ci/provider/base"
require "optimal/ci/provider/travis"
require "optimal/ci/provider/circle"
require "optimal/ci/client"
require "digest/md5"
require "rspec/optimal/formatters/documentation_formatter"
require 'rspec/core/option_parser'

module Optimal
  module CI
    class Error < StandardError; end
    # Your code goes here...
  end
end
