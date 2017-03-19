module TensorFlow::LibTensorFlow
  module Structs
    class Graph < FFI::Struct
      layout  :graph, :pointer
    end
  end
end
