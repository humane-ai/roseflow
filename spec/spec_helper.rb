require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "tensorflow"

RSpec.configure do |config|
  def api
    TensorFlow::LibTensorFlow::API
  end
end
