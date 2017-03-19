module TensorFlow::LibTensorFlow
  class OperationDescription < FFI::AutoPointer
    class << self
      def release(pointer)
        free
      end
    end
  end
end
