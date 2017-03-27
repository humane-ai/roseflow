module Roseflow::Tensorflow
  module Structs
    class OperationMetadata < FFI::ManagedStruct
      layout  :operation, Operation,
              :is_list, :bool,
              :list_size, :int64,
              :type, :pointer,
              :total_size, :int64
    end
  end
end
