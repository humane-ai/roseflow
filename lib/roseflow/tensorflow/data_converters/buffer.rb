module Roseflow::Tensorflow
  module DataConverters
    module Buffer
      extend FFI::DataConverter
      native_type FFI::Type::POINTER
    end
  end
end
