module TensorFlow::LibTensorFlow
  module Structs
    class WhileParams < FFI::ManagedStruct
      layout  :inputs, :int,
              :condition_graph, Graph,
              :condition_inputs, OperationOutput,
              :condition_output, OperationOutput,
              :body_graph, Graph,
              :body_inputs, OperationOutput,
              :body_output, OperationOutput,
              :name, :string
    end
  end
end
