module TensorFlow::LibTensorFlow
  module Structs
    class Code < FFI::Struct
      layout :code, :int
    end
  end
end
