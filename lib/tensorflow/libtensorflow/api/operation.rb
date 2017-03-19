module TensorFlow::LibTensorFlow
  module API
    #
    # Operation functions
    #
    operation_functions = {
      add_control_input: {
        name: "TF_AddControlInput",
        returns: :void,
        options: [ OperationDescription, Operation ]
      },
      add_input: {
        name: "TF_AddInput",
        returns: :void,
        options: [ OperationDescription, OperationOutput ]
      },
      add_input_list: {
        name: "TF_AddInputList",
        returns: :void,
        options: [ OperationDescription, :pointer, :int ]
      },
      finish_operation: {
        name: "TF_FinishOperation",
        returns: :pointer,
        options: [ OperationDescription, Status ]
      },
      new_operation: {
        name: "TF_NewOperation",
        returns: OperationDescription,
        options: [ Graph, :string, :string ]
      },
      operation_device: {
        name: "TF_OperationDevice",
        returns: :string,
        options: [ Operation ]
      },
      operation_input: {
        name: "TF_OperationInput",
        returns: OperationOutput,
        options: [ OperationInput ]
      },
      operation_input_list_length: {
        name: "TF_OperationInputListLength",
        returns: :int,
        options: [ Operation, :string, Status ]
      },
      operation_input_type: {
        name: "TF_OperationInputType",
        returns: :data_type,
        options: [ :pointer ]
      },
      operation_name: {
        name: "TF_OperationName",
        returns: :string,
        options: [ Operation ]
      },
      operation_number_of_inputs: {
        name: "TF_OperationNumInputs",
        returns: :int,
        options: [ Operation ]
      },
      operation_number_of_outputs: {
        name: "TF_OperationNumOutputs",
        returns: :int,
        options: [ Operation ]
      },
      operation_output_list_length: {
        name: "TF_OperationOutputListLength",
        returns: :int,
        options: [ Operation, :string, Status ]
      },
      operation_output_type: {
        name: "TF_OperationOutputType",
        returns: :data_type,
        options: [ :pointer ]
      },
      operation_type: {
        name: "TF_OperationOpType",
        returns: :string,
        options: [ Operation ]
      },
      set_attribute_boolean: {
        name: "TF_SetAttrBool",
        returns: :void,
        options: [ OperationDescription, :string, :char ]
      },
      set_attribute_float: {
        name: "TF_SetAttrFloat",
        returns: :void,
        options: [ OperationDescription, :string, :float ]
      },
      set_attribute_integer: {
        name: "TF_SetAttrInt",
        returns: :void,
        options: [ OperationDescription, :string, :int64 ]
      },
      set_attribute_shape: {
        name: "TF_SetAttrShape",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int ]
      },
      set_attribute_string: {
        name: "TF_SetAttrString",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :size_t ]
      },
      set_attribute_tensor: {
        name: "TF_SetAttrTensor",
        returns: :void,
        options: [ OperationDescription, :string, Tensor, Status ]
      },
      set_attribute_type: {
        name: "TF_SetAttrType",
        returns: :void,
        options: [ OperationDescription, :string, :data_type ]
      },
      set_device: {
        name: "TF_SetDevice",
        returns: :void,
        options: [ OperationDescription, :string ]
      }
    }

    operation_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
