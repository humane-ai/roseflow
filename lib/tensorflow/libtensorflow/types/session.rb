module TensorFlow::LibTensorFlow
  class Session < FFI::AutoPointer
    class << self
      def release(pointer)
        TensorFlow::LibTensorFlow::API.delete_session(pointer)
      end
    end
  end
end
