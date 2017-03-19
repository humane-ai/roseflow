module TensorFlow::LibTensorFlow
  module Structs
    class OperationOutput < FFI::ManagedStruct
      layout  :operation, Operation,
              :index, :int
    end
  end
end
