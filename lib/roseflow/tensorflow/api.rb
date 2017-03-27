require "roseflow/tensorflow/data_converters"
require "roseflow/tensorflow/structs"
require "roseflow/tensorflow/types"

module Roseflow::Tensorflow
  module API
    extend FFI::Library

    ffi_lib Roseflow::Tensorflow::LIB_SO_NAMES

    enum :data_type,  [ 0, :dt_float,
                        :dt_double,
                        :dt_int32,
                        :dt_uint8,
                        :dt_int16,
                        :dt_int8,
                        :dt_string,
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

    typedef ::Roseflow::Tensorflow::Buffer, :buffer
    typedef ::Roseflow::Tensorflow::Output, :output
  end
end

require "roseflow/tensorflow/api/buffer"
require "roseflow/tensorflow/api/core"
require "roseflow/tensorflow/api/graph"
require "roseflow/tensorflow/api/operation"
require "roseflow/tensorflow/api/session"
require "roseflow/tensorflow/api/tensor"
require "roseflow/tensorflow/api/utility"
