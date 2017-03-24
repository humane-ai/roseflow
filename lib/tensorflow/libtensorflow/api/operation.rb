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
        options: [ OperationDescription, :output ]
      },
      add_input_list: {
        name: "TF_AddInputList",
        returns: :void,
        options: [ OperationDescription, :pointer, :int ]
      },
      finish_operation: {
        name: "TF_FinishOperation",
        returns: Operation,
        options: [ OperationDescription, Status ]
      },
      get_all_operations: {
        name: "TF_GetAllOpList",
        returns: :buffer,
        options: []
      },
      new_operation: {
        name: "TF_NewOperation",
        returns: OperationDescription,
        options: [ Graph, :string, :string ]
      },
      operation_control_inputs: {
        name: "TF_OperationGetControlInputs",
        returns: :int,
        options: [ Operation, :pointer, :int ]
      },
      operation_control_outputs: {
        name: "TF_OperationGetControlOutputs",
        returns: :int,
        options: [ Operation, :pointer, :int ]
      },
      operation_device: {
        name: "TF_OperationDevice",
        returns: :string,
        options: [ Operation ]
      },
      operation_get_attribute_boolean: {
        name: "TF_OperationGetAttrBool",
        returns: :void,
        options: [ Operation, :string, :bool, Status ]
      },
      operation_get_attribute_boolean_list: {
        name: "TF_OperationGetAttrBoolList",
        returns: :void,
        options: [ Operation, :string, :pointer, :int, Status ]
      },
      operation_get_attribute_float: {
        name: "TF_OperationGetAttrFloat",
        returns: :void,
        options: [ Operation, :string, :pointer, Status ]
      },
      operation_get_attribute_float_list: {
        name: "TF_OperationGetAttrFloatList",
        returns: :void,
        options: [ Operation, :string, :pointer, :int, Status ]
      },
      operation_get_attribute_integer: {
        name: "TF_OperationGetAttrInt",
        returns: :void,
        options: [ Operation, :string, :int64, Status ]
      },
      operation_get_attribute_integer_list: {
        name: "TF_OperationGetAttrIntList",
        returns: :void,
        options: [ Operation, :string, :int64, :int, Status ]
      },
      operation_get_attribute_metadata: {
        name: "TF_OperationGetAttrMetadata",
        returns: OperationMetadata,
        options: [ Operation, :string, Status ]
      },
      operation_get_attribute_shape: {
        name: "TF_OperationGetAttrShape",
        returns: :void,
        options: [ Operation, :string, :pointer, :int, Status ]
      },
      operation_get_attribute_shape_list: {
        name: "TF_OperationGetAttrShapeList",
        returns: :void,
        options: [ Operation, :string, :pointer, :int, :int, :pointer, :int, Status ]
      },
      operation_get_attribute_string: {
        name: "TF_OperationGetAttrString",
        returns: :void,
        options: [ Operation, :string, :pointer, :size_t, Status ]
      },
      operation_get_attribute_string_list: {
        name: "TF_OperationGetAttrStringList",
        returns: :void,
        options: [ Operation, :string, :pointer, :size_t, :int, :pointer, :size_t, Status ]
      },
      operation_get_attribute_tensor: {
        name: "TF_OperationGetAttrTensor",
        returns: :void,
        options: [ Operation, :string, Tensor, Status ]
      },
      operation_get_attribute_tensor_list: {
        name: "TF_OperationGetAttrTensorList",
        returns: :void,
        options: [ Operation, :string, :pointer, :int, Status ]
      },
      operation_get_attribute_tensor_shape_proto: {
        name: "TF_OperationGetAttrTensorShapeProto",
        returns: :void,
        options: [ Operation, :string, :buffer, Status ]
      },
      operation_get_attribute_tensor_shape_proto_list: {
        name: "TF_OperationGetAttrTensorShapeProtoList",
        returns: :void,
        options: [ Operation, :string, :buffer, :int, Status ]
      },
      operation_get_attribute_type: {
        name: "TF_OperationGetAttrType",
        returns: :void,
        options: [ Operation, :string, :data_type, Status ]
      },
      operation_get_attribute_type_list: {
        name: "TF_OperationGetAttrTypeList",
        returns: :void,
        options: [ Operation, :string, :pointer, :int, Status ]
      },
      operation_get_attribute_value_proto: {
        name: "TF_OperationGetAttrValueProto",
        returns: :void,
        options: [ Operation, :string, :buffer, Status ]
      },
      operation_input: {
        name: "TF_OperationInput",
        returns: :output,
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
      operation_number_of_control_inputs: {
        name: "TF_OperationNumControlInputs",
        returns: :int,
        options: [ Operation ]
      },
      operation_number_of_control_outputs: {
        name: "TF_OperationNumControlOutputs",
        returns: :int,
        options: [ Operation ]
      },
      operation_number_of_output_consumers: {
        name: "TF_OperationOutputNumConsumers",
        returns: :int,
        options: [ :output ]
      },
      operation_output_consumers: {
        name: "TF_OperationOutputConsumers",
        returns: :int,
        options: [ :output, OperationInput, :int ]
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
      set_attribute_boolean_list: {
        name: "TF_SetAttrBoolList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int ]
      },
      set_attribute_float: {
        name: "TF_SetAttrFloat",
        returns: :void,
        options: [ OperationDescription, :string, :float ]
      },
      set_attribute_float_list: {
        name: "TF_SetAttrFloatList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int ]
      },
      set_attribute_integer: {
        name: "TF_SetAttrInt",
        returns: :void,
        options: [ OperationDescription, :string, :int64 ]
      },
      set_attribute_integer_list: {
        name: "TF_SetAttrIntList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int ]
      },
      set_attribute_shape: {
        name: "TF_SetAttrShape",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int ]
      },
      set_attribute_shape_list: {
        name: "TF_SetAttrShapeList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int, :int ]
      },
      set_attribute_string: {
        name: "TF_SetAttrString",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :size_t ]
      },
      set_attribute_string_list: {
        name: "TF_SetAttrStringList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :size_t, :int ]
      },
      set_attribute_tensor: {
        name: "TF_SetAttrTensor",
        returns: :void,
        options: [ OperationDescription, :string, Tensor, Status ]
      },
      set_attribute_tensor_list: {
        name: "TF_SetAttrTensorList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int, Status ]
      },
      set_attribute_tensor_shape_proto: {
        name: "TF_SetAttrTensorShapeProto",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :size_t, Status ]
      },
      set_attribute_tensor_shape_proto_list: {
        name: "TF_SetAttrTensorShapeProtoList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :size_t, :int, Status ]
      },
      set_attribute_type: {
        name: "TF_SetAttrType",
        returns: :void,
        options: [ OperationDescription, :string, :data_type ]
      },
      set_attribute_type_list: {
        name: "TF_SetAttrTypeList",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :int ]
      },
      set_attribute_value_proto: {
        name: "TF_SetAttrValueProto",
        returns: :void,
        options: [ OperationDescription, :string, :pointer, :size_t, Status ]
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
