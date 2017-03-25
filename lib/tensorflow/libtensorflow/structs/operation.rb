module TensorFlow::LibTensorFlow
  module Structs
    class Operation < FFI::Struct
      layout  :node, Node
    end
  end
end
