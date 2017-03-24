module TensorFlow::LibTensorFlow
  module Structs
    class WhileParams < FFI::ManagedStruct
      layout  :inputs, :int,
              :condition_graph, Graph,
              :condition_inputs, Output,
              :condition_output, Output,
              :body_graph, Graph,
              :body_inputs, Output,
              :body_output, Output,
              :name, :string
    end
  end
end
