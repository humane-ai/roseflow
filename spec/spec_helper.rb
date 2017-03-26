require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "tensorflow"
require "factory_girl"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  def api
    TensorFlow::LibTensorFlow::API
  end

  def fixture_path
    File.expand_path("../fixtures/", __FILE__)
  end
end
