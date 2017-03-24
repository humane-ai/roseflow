require "ffi"

module TensorFlow
  module LibTensorFlow
    LIB_SO_NAMES = [
      "libtensorflow.so".freeze
    ]
  end
end

require "tensorflow/libtensorflow/api"
require "tensorflow/libtensorflow/protobuf"
require "tensorflow/libtensorflow/utility"
