module TensorFlow::LibTensorFlow
  class OperationInput < FFI::AutoPointer
    class << self
      def release(pointer)
        free
      end
    end
  end
end
