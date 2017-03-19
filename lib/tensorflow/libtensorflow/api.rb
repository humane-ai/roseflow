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

    tensor_functions = {
      # extern TF_Tensor* TF_AllocateTensor(TF_DataType, const int64_t* dims,
      #                               int num_dims, size_t len);
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
        options: [ :int, :long_long, :int, :pointer, :int, :pointer, :pointer ]
      }
    }

    utility_functions = {
      # extern size_t TF_StringEncode(const char* src, size_t src_len, char* dst,
      #                         size_t dst_len, TF_Status* status);
      decode_string: {
        name: "TF_StringDecode",
        returns: :long_long,
        options: [ :string, :uint16, :pointer ]
      },
      encode_string: {
        name: "TF_StringEncode",
        returns: :long_long,
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
    [ core_functions, tensor_functions, utility_functions ].each do |functions|
      functions.each do |method_name, arguments|
        attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
      end
    end
  end
end
