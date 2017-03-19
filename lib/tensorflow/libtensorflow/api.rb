require "tensorflow/libtensorflow/data_converters"
require "tensorflow/libtensorflow/structs"
require "tensorflow/libtensorflow/types"

module TensorFlow::LibTensorFlow
  module API
    extend FFI::Library

    ffi_lib TensorFlow::LibTensorFlow::LIB_SO_NAMES

    enum :data_type,  [ :dt_float, 1,
                        :dt_double,
                        :dt_int32,
                        :dt_uint8,
                        :dt_int16,
                        :dt_int8,
                        :dt_string,
                        :dt_complex64,
                        :dt_complex,
                        :dt_int64,
                        :dt_bool,
                        :dt_qint8,
                        :dt_quint8,
                        :dt_qint32,
                        :dt_bfloat16,
                        :dt_qint16,
                        :dt_quint16,
                        :dt_uint16,
                        :dt_complex128,
                        :dt_half,
                        :dt_resource
                      ]

    enum :code, [
                  :ok, :cancelled, :unknown, :invalid_argument, :deadline_exceeded,
                  :not_found, :already_exists, :permission_denied, :resource_exhausted,
                  :failed_precondition, :aborted, :out_of_range, :unimplemented,
                  :internal, :unavailable, :data_loss, :unauthenticated
                ]
    #
    # Core functions
    #
    core_functions = {
      delete_status: {
        name: "TF_DeleteStatus",
        returns: :void,
        options: [:pointer]
      },
      get_code: {
        name: "TF_GetCode",
        returns: :code,
        options: [:pointer]
      },
      message: {
        name: "TF_Message",
        returns: :string,
        options: [:pointer]
      },
      new_status: {
        name: "TF_NewStatus",
        returns: Status,
        options: []
      },
      set_status: {
        name: "TF_SetStatus",
        returns: :void,
        options: [:pointer, :int, :string]
      },
      version: {
        name: "TF_Version",
        returns: UTF8String,
        options: []
      }
    }

    #
    # Session functions
    #
    session_functions = {
      close_session: {
        name: "TF_CloseSession",
        returns: :void,
        options: [ Session, Status ]
      },
      delete_session: {
        name: "TF_DeleteSession",
        returns: :void,
        options: [ Session, Status ]
      },
      new_session: {
        name: "TF_NewSession",
        returns: Session,
        options: [ Graph, SessionOptions, Status ]
      },
      run_session: {
        name: "TF_SessionRun",
        returns: :void,
        options: [ Session, Buffer, OperationOutput, Tensor, :int, OperationOutput, Tensor, :int, Operation, :int, Buffer, Status ]
      }
    }


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

    #
    # Tensor functions
    #
    tensor_functions = {
      allocate_tensor: {
        name: "TF_AllocateTensor",
        returns: Tensor,
        options: [ :int, :pointer, :int, :size_t ]
      },
      delete_tensor: {
        name: "TF_DeleteTensor",
        returns: :void,
        options: [ :pointer ]
      },
      new_tensor: {
        name: "TF_NewTensor",
        returns: :pointer,
        options: [ :int, :pointer, :int, :pointer, :size_t, :pointer, :pointer ]
      },
      number_of_tensor_dimensions: {
        name: "TF_NumDims",
        returns: :int,
        options: [ :pointer ]
      },
      tensor_byte_size: {
        name: "TF_TensorByteSize",
        returns: :size_t,
        options: [ :pointer ]
      },
      tensor_data: {
        name: "TF_TensorData",
        returns: TensorData,
        options: [ :pointer ]
      },
      tensor_length_in_dimension: {
        name: "TF_Dim",
        returns: :int64,
        options: [ :pointer, :int ]
      },
      tensor_type: {
        name: "TF_TensorType",
        returns: :data_type,
        options: [ :pointer ]
      }
    }

    #
    # Buffer related functions
    #
    buffer_functions = {
      delete_buffer: {
        name: "TF_DeleteBuffer",
        returns: :void,
        options: [ :pointer ]
      },
      get_buffer: {
        name: "TF_GetBuffer",
        returns: :pointer,
        options: [ :pointer ]
      },
      new_buffer: {
        name: "TF_NewBuffer",
        returns: Buffer,
        options: []
      },
      new_buffer_from_string: {
        name: "TF_NewBufferFromString",
        returns: Buffer,
        options: [ :string, :size_t ]
      }
    }

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

    #
    # Utility functions
    #
    utility_functions = {
      decode_string: {
        name: "TF_StringDecode",
        returns: :size_t,
        options: [ :string, :size_t, :string, :size_t, :pointer ]
      },
      encode_string: {
        name: "TF_StringEncode",
        returns: :size_t,
        options: [ :string, :size_t, :string, :size_t, :pointer ]
      },
      string_encoded_size: {
        name: "TF_StringEncodedSize",
        returns: :int,
        options: [:int]
      }
    }

    #
    # Attaching the functions
    #
    [ core_functions, session_functions, buffer_functions, graph_functions, operation_functions, tensor_functions, utility_functions ].each do |functions|
      functions.each do |method_name, arguments|
        attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
      end
    end
  end
end
