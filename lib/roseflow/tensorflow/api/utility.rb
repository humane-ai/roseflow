module Roseflow::Tensorflow
  module API
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

    utility_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
