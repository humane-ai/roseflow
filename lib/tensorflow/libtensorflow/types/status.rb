module TensorFlow::LibTensorFlow
  class Status < FFI::AutoPointer
    def code
      TensorFlow::LibTensorFlow::Api.get_code(self)
    end

    def clear
      TensorFlow::LibTensorFlow::Api.set_status(self, 0, "")
      true
    rescue
      false
    end

    def message
      TensorFlow::LibTensorFlow::Api.message(self)
    end

    class << self
      def release(pointer)
        TensorFlow::LibTensorFlow::Api.delete_status(pointer)
      end
    end
  end
end
