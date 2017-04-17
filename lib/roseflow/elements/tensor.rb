module Roseflow::Elements
  class Tensor < BaseProtobufElement
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::TensorProto

    def dimensions
      @dimensions ||= extract_shape
    end

    def extract_shape
      definition.tensor_shape.dim.map do |dim|
        dim.size
      end
    end
  end
end
