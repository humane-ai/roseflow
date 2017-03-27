module Roseflow::Tensorflow
  module Structs
    class Session < FFI::Struct
      layout  :status, :pointer
    end
  end
end
