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

    enum :attribute_type, [
                            :attr_string, :attr_int, :attr_float, :attr_boolean,
                            :attr_type, :attr_shape, :attr_tensor, :attr_placeholder,
                            :attr_function
                          ]

    typedef ::TensorFlow::LibTensorFlow::Buffer, :buffer
    typedef ::TensorFlow::LibTensorFlow::Output, :output
  end
end

require "tensorflow/libtensorflow/api/buffer"
require "tensorflow/libtensorflow/api/core"
require "tensorflow/libtensorflow/api/graph"
require "tensorflow/libtensorflow/api/operation"
require "tensorflow/libtensorflow/api/session"
require "tensorflow/libtensorflow/api/tensor"
require "tensorflow/libtensorflow/api/utility"
