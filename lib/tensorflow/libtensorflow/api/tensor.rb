module TensorFlow::LibTensorFlow
  module API
    #
    # Tensor functions
    #
    tensor_functions = {
      allocate_tensor: {
        name: "TF_AllocateTensor",
        returns: Tensor,
        options: [ :data_type, :pointer, :int, :size_t ]
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

    tensor_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
