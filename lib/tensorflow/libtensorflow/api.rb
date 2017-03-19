require "tensorflow/libtensorflow/structs"
require "tensorflow/libtensorflow/types"

module TensorFlow::LibTensorFlow
  module Api
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
        returns: :string,
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
    [ core_functions, buffer_functions, tensor_functions, utility_functions ].each do |functions|
      functions.each do |method_name, arguments|
        attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
      end
    end
  end
end
