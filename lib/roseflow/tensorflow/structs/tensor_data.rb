module Roseflow::Tensorflow
  module Structs
    class TensorData < FFI::ManagedStruct
      layout  :data, :pointer
    end
  end
end
