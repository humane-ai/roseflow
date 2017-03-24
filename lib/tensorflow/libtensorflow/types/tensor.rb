module TensorFlow::LibTensorFlow
  class Tensor < ManagedPointer
    class << self
      def to_native(value, ctx)
        attr_value = TensorFlow::LibTensorFlow::Protobuf::AttrValue.new
        attr_value.tensor = value
        attr_value.type = TensorFlow::LibTensorFlow::Protobuf::DataType::DT_STRING
        attr_value.to_proto
        # TensorFlow::LibTensorFlow::Protobuf::AttrValue.new(tensor: value, dtype: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_STRING).to_proto
      end
    end

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
