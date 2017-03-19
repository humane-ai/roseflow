module TensorFlow::LibTensorFlow
  class SessionOptions < FFI::AutoPointer
    class << self
      def release(pointer)
        free
      end
    end
  end
end
