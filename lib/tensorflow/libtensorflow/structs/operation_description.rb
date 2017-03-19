module TensorFlow::LibTensorFlow
  module Structs
    class OperationDescription < FFI::ManagedStruct
      layout  :graph, Graph
    end
  end
end
