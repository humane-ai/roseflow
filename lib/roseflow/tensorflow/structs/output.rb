module Roseflow::Tensorflow
  module Structs
    class Output < FFI::Struct
      layout  :oper, Operation,
              :index, :int
    end
  end
end
