module TensorFlow::LibTensorFlow
  class OperationOutput < FFI::AutoPointer
    class << self
      def release(pointer)
        free
      end
    end
  end
end
