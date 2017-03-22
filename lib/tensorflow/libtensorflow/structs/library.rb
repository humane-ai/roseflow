module TensorFlow::LibTensorFlow
  module Structs
    class Library < FFI::ManagedStruct
      layout  :name, :string
    end
  end
end
