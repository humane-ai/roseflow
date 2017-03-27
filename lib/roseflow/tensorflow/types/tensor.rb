module Roseflow::Tensorflow
  class Tensor < ManagedPointer
    class << self
      def to_native(value, ctx)
        attr_value = Roseflow::Tensorflow::Protobuf::AttrValue.new
        attr_value.tensor = value.to_tensor_proto
        attr_value.type = Roseflow::Tensorflow::Protobuf::DataType::DT_STRING
        attr_value.to_proto
        # Roseflow::Tensorflow::Protobuf::AttrValue.new(tensor: value, dtype: Roseflow::Tensorflow::Protobuf::DataType::DT_STRING).to_proto
      end
    end

    def dimensions
      Roseflow::Tensorflow::API.number_of_tensor_dimensions(self)
    end

    def byte_size
      Roseflow::Tensorflow::API.tensor_byte_size(self)
    end

    def data
      Roseflow::Tensorflow::API.tensor_data(self)
    end

    def length(dimension)
      Roseflow::Tensorflow::API.tensor_length_in_dimension(self, dimension)
    end

    def type
      Roseflow::Tensorflow::API.tensor_type(self)
    end
  end
end
