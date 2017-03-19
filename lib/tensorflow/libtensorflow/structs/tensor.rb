module TensorFlow::LibTensorFlow
  module Structs
    class Tensor < FFI::ManagedStruct
      layout  :data_type, :int,
              :dimensions, :long_long,
              :dimension_count, :int,
              :data, :pointer,
              :length, :int
    end
  end
end
