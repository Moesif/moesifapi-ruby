

require 'json'
require 'test/unit'
require_relative '../../lib/moesif_api.rb'
require_relative '../test_helper.rb'
require_relative '../http_response_catcher.rb'

class ControllerTestBase < Test::Unit::TestCase
  include MoesifApi

  class << self
    attr_accessor :controller
  end

  # Called only once for a test class before any test has executed.
  def self.startup
    @@api_client = MoesifAPIClient.new("Your Moesif Application Id")
    @@request_timeout = 30
    @@assert_precision = 0.01
  end

  # Called once before every test case.
  def setup
    @response_catcher = HttpResponseCatcher.new
    self.class.controller.http_call_back = @response_catcher
  end
end
