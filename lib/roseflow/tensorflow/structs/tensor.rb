module Roseflow::Tensorflow
  module Structs
    class Tensor < FFI::Struct
      layout  :data_type, :int,
              :dimensions, :long_long,
              :dimension_count, :int,
              :data, :pointer,
              :length, :int

      def to_tensor_proto
        
      end
    end
  end
end
