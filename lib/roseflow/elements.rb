module Roseflow::Elements
  extend ActiveSupport::Autoload

  autoload :BaseElement
  autoload :BaseProtobufElement
  autoload :Bias
  autoload :AttrValue
  autoload :DataType
  autoload :Input
  autoload :Output
  autoload :Placeholder
  autoload :TensorShape
  autoload :Tensor
  autoload :Variable
  autoload :Weight
end
