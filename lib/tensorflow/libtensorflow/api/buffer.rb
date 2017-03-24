module TensorFlow::LibTensorFlow
  module API
    #
    # Buffer functions
    #
    buffer_functions = {
      delete_buffer: {
        name: "TF_DeleteBuffer",
        returns: :void,
        options: [ :buffer ]
      },
      get_buffer: {
        name: "TF_GetBuffer",
        returns: :buffer,
        options: [ :pointer ]
      },
      new_buffer: {
        name: "TF_NewBuffer",
        returns: :buffer,
        options: []
      },
      new_buffer_from_string: {
        name: "TF_NewBufferFromString",
        returns: :buffer,
        options: [ :string, :size_t ]
      }
    }

    buffer_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
