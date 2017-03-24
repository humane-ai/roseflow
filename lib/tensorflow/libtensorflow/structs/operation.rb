module TensorFlow::LibTensorFlow
  module Structs
    class Operation < FFI::Struct
      layout  :graph, Graph
    end
  end
end
