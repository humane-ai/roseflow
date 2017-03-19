module TensorFlow::LibTensorFlow
  module Api
    extend FFI::Library

    ffi_lib TensorFlow::LibTensorFlow::LIB_SO_NAMES

    #
    # Core functions
    #
    core_functions = {
      Version: [[], :string]
    }

    #
    # Attaching the functions
    #
    [ core_functions ].each do |functions|
      functions.each do |symbol, arguments|
        attach_function "TF_#{symbol}".to_sym, arguments[0], arguments[1]
      end
    end
  end
end
