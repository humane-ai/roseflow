module Roseflow::Tensorflow
  module Structs
    class Status < FFI::Struct
      layout  :status, :pointer,
              :code, :int
    end
  end
end
