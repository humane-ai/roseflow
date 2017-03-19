module TensorFlow::LibTensorFlow
  class Code < FFI::AutoPointer
    class << self
      def release(pointer)
        p "You should release the pointer"
      end
    end
  end
end
