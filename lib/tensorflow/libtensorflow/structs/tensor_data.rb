module TensorFlow::LibTensorFlow
  module Structs
    class TensorData < FFI::ManagedStruct
      layout  :data, :pointer
    end
  end
end
