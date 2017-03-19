module TensorFlow::LibTensorFlow
  class Tensor < FFI::AutoPointer
    def dimensions
      @dimensions
    end

    class << self
      def release(pointer)
        TensorFlow::LibTensorFlow::Api.delete_tensor(pointer)
      end
    end
  end
end
