module TensorFlow::LibTensorFlow
  module Structs
    class Buffer < FFI::ManagedStruct
      layout  :data, :pointer,
              :length, :size_t
    end
  end
end
