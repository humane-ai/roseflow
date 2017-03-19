module TensorFlow::LibTensorFlow
  class Status < ManagedPointer
    def code
      TensorFlow::LibTensorFlow::API.get_code(self)
    end

    def clear
      TensorFlow::LibTensorFlow::API.set_status(self, 0, "")
      true
    rescue
      false
    end

    def message
      TensorFlow::LibTensorFlow::API.message(self)
    end
  end
end
