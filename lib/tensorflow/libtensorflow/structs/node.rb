module TensorFlow::LibTensorFlow
  module Structs
    class Node < FFI::Struct
      layout :data, :pointer
      # layout  :rank, :int32,
      #         :visited, :bool,
      #         :data, :pointer,
      #         :in, :pointer,
      #         :out, :pointer
    end
  end
end
