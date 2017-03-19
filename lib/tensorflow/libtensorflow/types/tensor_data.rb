module TensorFlow::LibTensorFlow
  class TensorData < FFI::AutoPointer
    class << self
      def release(pointer)
        free
      end
    end
  end
end
