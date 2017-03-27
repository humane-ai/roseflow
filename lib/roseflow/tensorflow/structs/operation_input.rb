module Roseflow::Tensorflow
  module Structs
    class OperationInput < FFI::ManagedStruct
      layout  :operation, Operation,
              :index, :int
    end
  end
end
