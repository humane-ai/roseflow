module TensorFlow::LibTensorFlow
  class Output < ManagedPointer
    class << self
      def to_native(value, ctx)
        p "WORKING ON OUTPUTS"
        # TensorFlow::LibTensorFlow::Protobuf::NodeDef.new(name: "hello", op: value.to_proto).to_proto
        value
      end
    end
  end
end
