module TensorFlow::LibTensorFlow
  class Tensor < ManagedPointer
    def dimensions
      TensorFlow::LibTensorFlow::API.number_of_tensor_dimensions(self)
    end

    def byte_size
      TensorFlow::LibTensorFlow::API.tensor_byte_size(self)
    end

    def data
      TensorFlow::LibTensorFlow::API.tensor_data(self)
    end

    def length(dimension)
      TensorFlow::LibTensorFlow::API.tensor_length_in_dimension(self, dimension)
    end

    def type
      TensorFlow::LibTensorFlow::API.tensor_type(self)
    end
  end
end
