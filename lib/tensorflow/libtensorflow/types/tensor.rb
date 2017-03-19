module TensorFlow::LibTensorFlow
  class Tensor < FFI::AutoPointer
    def dimensions
      TensorFlow::LibTensorFlow::Api.number_of_tensor_dimensions(self)
    end

    def byte_size
      TensorFlow::LibTensorFlow::Api.tensor_byte_size(self)
    end

    def data
      TensorFlow::LibTensorFlow::Api.tensor_data(self)
    end

    def length(dimension)
      TensorFlow::LibTensorFlow::Api.tensor_length_in_dimension(self, dimension)
    end

    def type
      TensorFlow::LibTensorFlow::Api.tensor_type(self)
    end

    class << self
      def release(pointer)
        TensorFlow::LibTensorFlow::Api.delete_tensor(pointer)
      end
    end
  end
end
