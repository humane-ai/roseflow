module Roseflow::Tensorflow
  module Structs
    class SessionOptions < FFI::Struct
      layout  :options, :pointer
    end
  end
end
