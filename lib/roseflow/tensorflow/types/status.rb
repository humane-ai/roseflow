module Roseflow::Tensorflow
  class Status < ManagedPointer
    def code
      Roseflow::Tensorflow::API.get_code(self)
    end

    def clear
      Roseflow::Tensorflow::API.set_status(self, 0, "")
      true
    rescue
      false
    end

    def message
      Roseflow::Tensorflow::API.message(self)
    end
  end
end
