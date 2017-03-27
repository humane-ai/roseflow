module Roseflow::Tensorflow
  module Structs
    class Library < FFI::ManagedStruct
      layout  :name, :string
    end
  end
end
