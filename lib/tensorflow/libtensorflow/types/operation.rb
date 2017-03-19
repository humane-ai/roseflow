module TensorFlow::LibTensorFlow
  class Operation < FFI::AutoPointer
    class << self
      def release(pointer)
        free
      end
    end
  end
end
