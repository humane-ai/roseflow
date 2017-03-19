module TensorFlow::LibTensorFlow
  module Structs
    class Status < FFI::Struct
      layout  :status, :pointer,
              :code, :int

      def self.release(pointer)
        TensorFlow::LibTensorFlow.destroy_status(pointer)
      end
    end
  end
end
