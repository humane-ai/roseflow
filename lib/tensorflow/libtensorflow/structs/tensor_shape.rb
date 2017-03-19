module TensorFlow::LibTensorFlow
  module Structs
    class TensorShape < FFI::Struct
      layout  :shape, :long_long
    end
  end
end
