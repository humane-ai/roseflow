module TensorFlow::LibTensorFlow
  class Graph < FFI::AutoPointer
    class << self
      def release(pointer)
        TensorFlow::LibTensorFlow::API.delete_graph(pointer)
      end
    end
  end
end
