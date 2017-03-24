module TensorFlow::LibTensorFlow
  module Structs
    class Buffer < FFI::Struct
      layout  :data, :pointer,
              :length, :size_t
    end
  end
end
