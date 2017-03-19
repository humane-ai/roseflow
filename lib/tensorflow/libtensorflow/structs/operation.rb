module TensorFlow::LibTensorFlow
  module Structs
    class Operation < FFI::ManagedStruct
      layout  :graph, :pointer
    end
  end
end
