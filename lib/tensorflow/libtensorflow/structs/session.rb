module TensorFlow::LibTensorFlow
  module Structs
    class Session < FFI::Struct
      layout  :status, :pointer
    end
  end
end
