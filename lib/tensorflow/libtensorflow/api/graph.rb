module TensorFlow::LibTensorFlow
  module API
    #
    # Graph functions
    #
    graph_functions = {
      delete_graph: {
        name: "TF_DeleteGraph",
        returns: :void,
        options: [ Graph ]
      },
      graph_operation_by_name: {
        name: "TF_GraphOperationByName",
        returns: Operation,
        options: [ Graph, :string ]
      },
      graph_next_operation: {
        name: "TF_GraphNextOperation",
        returns: Operation,
        options: [ Graph, :size_t ]
      },
      graph_to_graph_definition: {
        name: "TF_GraphToGraphDef",
        returns: :void,
        options: [ Graph, Buffer, Status ]
      },
      new_graph: {
        name: "TF_NewGraph",
        returns: Graph,
        options: []
      }
    }

    graph_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
